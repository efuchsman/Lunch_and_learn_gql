require 'rails_helper'

RSpec.describe YoutubeService do
  it 'exists' do
    youtube = YoutubeService.new

    expect(youtube).to be_an_instance_of(YoutubeService)
  end

  describe "Class Methods" do
    describe "#videos_of_country" do
      it "returns videos of a country", :vcr do
        italy = YoutubeService.videos_of_country("italy")

        expect(italy).to be_a Hash
        expect(italy).to have_key :items
        expect(italy[:items]).to be_a Array
        expect(italy[:items].first).to be_a Hash
        expect(italy[:items].first).to have_key :snippet
      end
    end
  end
end
