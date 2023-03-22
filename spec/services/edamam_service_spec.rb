require 'rails_helper'

RSpec.describe EdamamService do
  it "exists" do
    edmam = EdamamService.new

    expect(edmam).to be_an_instance_of(EdamamService)
  end

  describe "Class Methods" do
    describe "#recipes_by_country" do
      it "displays recipes for a given country", :vcr do
        country = EdamamService.recipes_by_country("japan")

        expect(country).to be_a Hash
        expect(country).to have_key :hits
        expect(country[:hits]).to be_a Array
        expect(country[:hits].first).to have_key :recipe
      end
    end
  end
end
