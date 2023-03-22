require 'rails_helper'

RSpec.describe RestCountriesFacade do
  it 'exists' do
    countries = RestCountriesFacade.new

    expect(countries).to be_an_instance_of(RestCountriesFacade)
  end

  describe "Class Methods" do
    describe "#all_countries" do
      it "returns all countries as objects", :vcr do

        countries = RestCountriesFacade.all_countries

        expect(countries).to be_a Array
        expect(countries.first).to be_a RestCountry
      end
    end

    describe "#random_country" do
      it "selects a random country", :vcr do

        expect(RestCountriesFacade.random_country).to be_a RestCountry
      end
    end
  end
end
