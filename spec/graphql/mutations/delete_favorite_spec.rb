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
      end
    end
  end
end
