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

      result = LunchAndLearnGqlSchema.execute(query).as_json
      output = result['data']['randomRestCountry']

      expect(output).to be_a Hash
      expect(output).to have_key "name"
      expect(output).to have_key "capital"
    end
  end
end
