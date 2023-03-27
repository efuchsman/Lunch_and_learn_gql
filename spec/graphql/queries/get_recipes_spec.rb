require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "recipes" do
    describe "When the records exist" do
      it "returns recipes", :vcr do
        query =
        <<~GQL
          {
            recipes(country: "USA"){
              title
              url
              image
              country
            }
          }
        GQL

        result = LunchAndLearnGqlSchema.execute(query).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :data
        expect(json[:data]).to be_a Hash
        expect(json[:data]).to have_key :recipes
        expect(json[:data][:recipes]).to be_a Array
        expect(json[:data][:recipes].first).to have_key :title
        expect(json[:data][:recipes].first).to have_key :url
        expect(json[:data][:recipes].first).to have_key :image
        expect(json[:data][:recipes].first).to have_key :country
      end
    end
  end

  describe "when the records DNE" do
    it "returns a blank array", :vcr do
      query =
        <<~GQL
          {
            recipes(country: "US2"){
              title
              url
              image
              country
            }
          }
        GQL

      result = LunchAndLearnGqlSchema.execute(query).to_json
      json = JSON.parse(result, symbolize_names: true)

      expect(json).to be_a Hash
      expect(json).to have_key :data
      expect(json[:data]).to be_a Hash
      expect(json[:data]).to have_key :recipes
      expect(json[:data][:recipes]).to be_a Array
      expect(json[:data][:recipes]).to eq([])
    end
  end

  describe "When there is no country param" do
    it "returns an error", :vcr do
      query =
        <<~GQL
          {
            recipes{
              title
              url
              image
              country
            }
          }
        GQL

    result = LunchAndLearnGqlSchema.execute(query).to_json
    json = JSON.parse(result, symbolize_names: true)

    expect(json).to be_a Hash
    expect(json).to have_key :errors
    expect(json[:errors]).to be_a Array
    expect(json[:errors].first).to have_key :message
    expect(json[:errors].first[:message]).to eq("Field 'recipes' is missing required arguments: country")
    end
  end
end
