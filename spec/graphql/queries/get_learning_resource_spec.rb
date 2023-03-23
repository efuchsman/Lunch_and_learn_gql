require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "learning_resource" do
    describe "When the country exists" do
      it "returns a random country", :vcr do
        query =
          <<~GQL
            {
              learningResource(country: "italy"){
                country
                video {
                  title
                  youtubeVideoId
                }
                images {
                  altTag
                  url
                }
              }
            }
          GQL

        result = LunchAndLearnGqlSchema.execute(query).to_json
        json = JSON.parse(result, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json).to have_key :data
        expect(json[:data]).to be_a Hash
        expect(json[:data]).to have_key :learningResource
        expect(json[:data][:learningResource].keys).to eq([:country, :video, :images])
        expect(json[:data][:learningResource][:video].keys).to eq([:title, :youtubeVideoId])
        expect(json[:data][:learningResource][:images]).to be_a Array
        expect(json[:data][:learningResource][:images].first.keys).to eq([:altTag, :url])
      end
    end
  end
end
