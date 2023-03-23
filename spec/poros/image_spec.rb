require "rails_helper"

RSpec.describe Image do
  it "exists and has readable attributes" do

    data = {
      alt_description: "brown wooden boat on beach during daytime",
      urls: {
        regular: "https://images.unsplash.com/photo-1594471383603-d4cd2bde19d4?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzOTk0NjN8MHwxfHNlYXJjaHwxfHxraXJpYmF0aXxlbnwwfHx8fDE2NzM4Mjg2NDg&ixlib=rb-4.0.3&q=80"
      }
    }

    image = Image.new(data)

    expect(image).to be_an_instance_of(Image)
    expect(image.alt_tag).to eq("brown wooden boat on beach during daytime")
    expect(image.url).to eq("https://images.unsplash.com/photo-1594471383603-d4cd2bde19d4?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzOTk0NjN8MHwxfHNlYXJjaHwxfHxraXJpYmF0aXxlbnwwfHx8fDE2NzM4Mjg2NDg&ixlib=rb-4.0.3&q=80")
  end
end
