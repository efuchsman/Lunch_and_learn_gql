require 'rails_helper'

RSpec.describe RestCountriesService do
  it "exists" do
    rest_countries = RestCountriesService.new

    expect(rest_countries).to be_an_instance_of(RestCountriesService)
  end

  describe "Class Methods" do
    describe "#all_countries" do
      it "returns all countries", :vcr do

        expect(RestCountriesService.all_countries).to be_a Array
        expect(RestCountriesService.all_countries.first).to have_key :name
        expect(RestCountriesService.all_countries.first).to have_key :capital
        expect(RestCountriesService.all_countries.first[:name]).to be_a Hash
        expect(RestCountriesService.all_countries.first[:name]).to have_key :common
        expect(RestCountriesService.all_countries.first[:name]).to have_key :official
        expect(RestCountriesService.all_countries.first[:name][:common]).to be_a String
        expect(RestCountriesService.all_countries.first[:name][:official]).to be_a String
        expect(RestCountriesService.all_countries.first[:capital]).to be_a Array
      end
    end
  end
end
