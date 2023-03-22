require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "rest_countries" do
    it "can return all rest_countries", :vcr do
      query =
        <<~GQL
          {
            restCountries {
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
      expect(json[:data]).to have_key :restCountries
      expect(json[:data][:restCountries]).to be_a Array
      expect(json[:data][:restCountries].first).to have_key :name
      expect(json[:data][:restCountries].first).to have_key :capital
    end
  end
end
