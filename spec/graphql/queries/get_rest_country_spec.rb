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

      result = LunchAndLearnGqlSchema.execute(query).as_json
      output = result['data']['restCountries']

      expect(output).to be_a Array
      expect(output.first).to have_key "name"
      expect(output.first).to have_key "capital"
    end
  end
end
