require 'rails_helper'

RSpec.describe Recipe do
  it "exists and has attributes" do

    data = {
      recipe: {
        label: "Passport to Japan: Edamame, Gyoza, Rice and Teriyaki Beef",
        image: "https://edamam-product-images.s3.amazonaws.com/web-img/237/2374bd7d348b32ba325739f8d9169119.jpeg",
        url: "https://www.foodnetwork.com/recipes/rachael-ray/passport-to-japan-edamame-gyoza-rice-and-teriyaki-beef-recipe-2013871"
      }
    }

    recipe = Recipe.new(data, "japan")

    expect(recipe).to be_an_instance_of(Recipe)
    expect(recipe.title).to eq("Passport to Japan: Edamame, Gyoza, Rice and Teriyaki Beef")
    expect(recipe.image).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/237/2374bd7d348b32ba325739f8d9169119.jpeg")
    expect(recipe.url).to eq("https://www.foodnetwork.com/recipes/rachael-ray/passport-to-japan-edamame-gyoza-rice-and-teriyaki-beef-recipe-2013871")
    expect(recipe.country).to eq("Japan")

  end
end
