require 'rails_helper'

RSpec.describe RecipeFacade do
  it "exists" do
    recipe_facade = RecipeFacade.new

    expect(recipe_facade).to be_an_instance_of(RecipeFacade)
  end

  describe "Class Methods" do
    describe "#recipes_by_country" do
      it "creates recipe objects from recipes based on a given country" do
        json_response = File.read('spec/fixtures/DO_NOT_DELETE/japan.json')
        stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{ENV['edamam_app_id']}&app_key=#{ENV['edamam_api_key']}&q=Japan&type=public").to_return(status: 200, body: json_response)


        expect(RecipeFacade.recipes_by_country("japan")).to be_a Array
        expect(RecipeFacade.recipes_by_country("japan").first).to be_a Recipe
      end

      describe "If there have been too many API calls" do
        it "returns 'Usage limits are exceeded'" do
          json_response = File.read('spec/fixtures/DO_NOT_DELETE/edamam_error.json')
          stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{ENV['edamam_app_id']}&app_key=#{ENV['edamam_api_key']}&q=Japan&type=public").to_return(status: 404, body: json_response)

          expect(RecipeFacade.recipes_by_country("japan")).to be_a String
          expect(RecipeFacade.recipes_by_country("japan")).to eq("Usage limits are exceeded")
        end
      end
    end
  end
end
