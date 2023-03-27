require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "random_rest_country" do
    it "returns a random country", :vcr do
      query =
        <<~GQL
          {
            randomRestCountry {
            name
            capital
            }
          }
        GQL

      result = LunchAndLearnGqlSchema.execute(query).to_json
      json = JSON.parse(result, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key :data
      expect(json[:data]).to be_a Hash
      expect(json[:data]).to have_key :randomRestCountry
      expect(json[:data][:randomRestCountry]).to have_key :capital
      expect(json[:data][:randomRestCountry]).to have_key :name
    end
  end
end
