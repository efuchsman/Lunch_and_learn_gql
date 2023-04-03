require 'rails_helper'


RSpec.describe Mutations::CreateFavorite, type: :request do
  describe "creating a new favorite" do

    let!(:user) { User.create(name: "Athena Dao", email: "athenadao@bestgirlever.com") }

    before :each do
      @query =
          <<~GQL
            mutation {
              createFavorite(input: {params: {country: "USA", recipeTitle: "72oz Tomahawk Ribeye", recipeLink: "https://www.somelink.com"}, apiKey: "#{user.api_key}"}){
                favorite {
                  id
                  country
                  recipeTitle
                  recipeLink
                  userId
                }
              }
            }
          GQL

      @query2 =
          <<~GQL
            {
              user(apiKey: "#{user.api_key}"){
                id
                name
                email
                apiKey
                favorites{
                  id
                  country
                  recipeTitle
                  recipeLink
                  userId
                }
              }
            }
          GQL

    end

    describe "when the user exists" do
      it "creates a favorite", :vcr do
        result1 = LunchAndLearnGqlSchema.execute(@query2).to_json
        json1 = JSON.parse(result1, symbolize_names: true)

        expect(json1[:data][:user].keys).to eq([:id, :name, :email, :apiKey, :favorites])
        expect(json1[:data][:user][:favorites]).to eq([])

        result2 = LunchAndLearnGqlSchema.execute(@query).to_json
        json2 = JSON.parse(result2, symbolize_names: true)

        result1 = LunchAndLearnGqlSchema.execute(@query2).to_json
        json1 = JSON.parse(result1, symbolize_names: true)

        expect(json1[:data][:user][:favorites]).to eq([json2[:data][:createFavorite][:favorite]])
      end
    end

    describe "when the user does not exist or the apiKey is null" do
      it "throws an error", :vcr do
        query =
          <<~GQL
            mutation {
              createFavorite(input: {params: {country: "USA", recipeTitle: "72oz Tomahawk Ribeye", recipeLink: "https://www.somelink.com"}, apiKey: "huh9hy98y9hug87g87go8"}){
                favorite {
                  id
                  country
                  recipeTitle
                  recipeLink
                  userId
                }
              }
            }
          GQL

        result = LunchAndLearnGqlSchema.execute(query).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first[:message]).to eq("No User found with the apiKey provided")
      end
    end

    describe "When required params are missing" do
      it "throws an error", :vcr do
        query =
          <<~GQL
            mutation {
              createFavorite(input: {params: { country: "", recipeTitle: "72oz Tomahawk Ribeye", recipeLink: "https://www.somelink.com" }, apiKey: "#{user.api_key}"}){
                favorite {
                  id
                  country
                  recipeTitle
                  recipeLink
                  userId
                }
              }
            }
          GQL

        result = LunchAndLearnGqlSchema.execute(query).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first).to have_key :message
        expect(json[:errors].first[:message]).to eq("Invalid attributes for Favorite: Country can't be blank")
      end
    end
  end
end
