require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "User" do
    describe "When the record exists" do
      let!(:user) { User.create(name: "Eli Fuchsman", email: "eli@mail.com") }

      before :each do
        @query =
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
                }
              }
            }
          GQL
      end

      it "returns a user", :vcr do
        result = LunchAndLearnGqlSchema.execute(@query).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :data
        expect(json[:data]).to have_key :user
        expect(json[:data][:user].keys).to eq([:id, :name, :email, :apiKey, :favorites])
      end
    end

    describe "When the record does not exist" do
      it "returns null" do
        query2 =
          <<~GQL
            {
              user(apiKey: "12345"){
                id
                name
                email
                apiKey
                favorites{
                  id
                  country
                  recipeTitle
                  recipeLink
                }
              }
            }
          GQL

        result = LunchAndLearnGqlSchema.execute(query2).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to have_key :data
        expect(json[:data]).to have_key :user
        expect(json[:data][:user]).to be nil
      end
    end

    describe "When no apiKey is provided" do
      it "returns an error" do
        query2 =
          <<~GQL
            {
              user{
                id
                name
                email
                apiKey
                favorites{
                  id
                  country
                  recipeTitle
                  recipeLink
                }
              }
            }
          GQL

        result = LunchAndLearnGqlSchema.execute(query2).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to have_key :errors
        expect(json[:errors]).to be_a Array
        expect(json[:errors].first).to have_key :message
        expect(json[:errors].first[:message]).to eq("Field 'user' is missing required arguments: apiKey")
      end
    end
  end
end
