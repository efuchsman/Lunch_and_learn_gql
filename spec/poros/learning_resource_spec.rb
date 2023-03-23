require 'rails_helper'

RSpec.describe LearningResource do
  it "exists and readable attributes", :vr do
    country = "kiribati"
    video = VideoFacade.country_video(country)
    images = ImageFacade.country_images(country)

    learning_resource = LearningResource.new(country, video, images)

    expect(learning_resource).to be_an_instance_of(LearningResource)
    expect(learning_resource.country).to eq("kiribati")
    expect(learning_resource.video).to be_a Video
    expect(learning_resource.images.first).to be_a Image
  end
end
