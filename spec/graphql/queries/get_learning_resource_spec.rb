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

      end
    end
  end
end
