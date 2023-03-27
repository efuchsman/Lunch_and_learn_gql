require 'rails_helper'

RSpec.describe VideoFacade do
  it 'exists' do
    video = VideoFacade.new

    expect(video).to be_an_instance_of(VideoFacade)
  end

  describe "Class Methods" do
    describe "#country_video" do
      it "returns a video on the quick history of a country", :vcr do
        country = "kiribati"

        video = VideoFacade.country_video(country)

        expect(video).to be_a Video
      end
    end
  end
end
