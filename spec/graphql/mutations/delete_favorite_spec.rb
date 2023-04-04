require 'rails_helper'

RSpec.describe Mutations::DeleteFavorite, type: :request do
  describe "Deleting an existing favorite" do
    let!(:user) { User.create(name: "Athena Dao", email: "athenadao@bestgirlever.com") }
    let!(:favorite) { Favorite.create(country: "USA", recipe_title: "72oz Tomahawk Ribeye", recipe_link: "https://www.somelink.com", user_id: user.id) }

    describe "When the user and favorite exist" do
      before :each do
        @query =
          <<~GQL
            mutation {
              deleteFavorite(input: {id: "#{favorite.id}", apiKey: "#{user.api_key}"}) {
                success
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

      it "deletes the favorite", :vcr do

        result1 = LunchAndLearnGqlSchema.execute(@query2).to_json
        json1 = JSON.parse(result1, symbolize_names: true)

        expect(json1[:data][:user].keys).to eq([:id, :name, :email, :apiKey, :favorites])
        expect(json1[:data][:user][:favorites].count).to eq 1

        result2 = LunchAndLearnGqlSchema.execute(@query).to_json
        json2 = JSON.parse(result2, symbolize_names: true)

        expect(json2).to be_a Hash
        expect(json2).to have_key :data
        expect(json2[:data]).to have_key :deleteFavorite
        expect(json2[:data][:deleteFavorite]).to have_key :success
        expect(json2[:data][:deleteFavorite][:success]).to eq("Favorite successfully deleted")

        expect(user.favorites.count).to eq 0
      end
    end

    describe "When the User DNE" do
      it "throws an error", :vcr do
        query =
          <<~GQL
              mutation {
                deleteFavorite(input: {id: "#{favorite.id}", apiKey: "#{user.id}"}) {
                  success
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

    describe "When the Favorite DNE" do
      it "Throws an error", :vcr do
        query =
          <<~GQL
              mutation {
                deleteFavorite(input: {id: "90000", apiKey: "#{user.api_key}"}) {
                  success
                }
              }
            GQL

        result = LunchAndLearnGqlSchema.execute(query).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first[:message]).to eq("No Favorite found with the ID provided")
      end
    end
  end
end
