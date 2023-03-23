require 'rails_helper'

RSpec.describe ImageFacade do
  it 'exists' do
    images = ImageFacade.new

    expect(images).to be_an_instance_of(ImageFacade)
  end

  describe "Class Methods" do
    describe "#country_images" do
      it "creates image objects", :vcr do
        country = "kiribati"
        images = ImageFacade.country_images(country)

        expect(images).to be_a Array
        expect(images.first).to be_a Image
      end
    end
  end
end
