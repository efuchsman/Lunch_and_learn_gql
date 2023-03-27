require 'rails_helper'

RSpec.describe Video do
  it "exists and has readable attributes" do

    data = {
      id: {
        videoId: "blah"
      },
      snippet: {
        title: "blah blah"
      }
    }

    video = Video.new(data)
    expect(video.youtube_video_id).to eq("blah")
    expect(video.title).to eq("blah blah")
  end
end
