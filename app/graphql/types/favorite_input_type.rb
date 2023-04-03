module Types
  class FavoriteInputType < Types::BaseInputObject
    argument :country, String, required: true
    argument :recipe_link, String, required: true
    argument :recipe_title, String, required: true
  end
end
