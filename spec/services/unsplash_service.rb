require 'rails_helper'

RSpec.describe UnsplashService do
  it "exists" do
    unsplash = UnsplashService.new

    expect(unsplash).to be_an_instance_of(UnsplashService)
  end

  describe "Class Methods" do
    describe "#country_images" do
      it "returns images as json", :vcr do
        country = "kiribati"

        images = UnsplashService.country_images(country)

        expect(images).to be_a Hash
        expect(images).to have_key :results
        expect(images[:results]).to be_a Array
      end
    end
  end
end
