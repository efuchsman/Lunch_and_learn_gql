module Mutations
  class CreateFavorite < Mutations::BaseMutation
    argument :api_key, String, required: true
    argument :country, String, required: true
    argument :recipe_link, String, required: true
    argument :recipe_title, String, required: true


    field :user, Types::UserType, null: false
    field :favorites, [Types::FavoriteType], null: true

    def resolve(:api_key, :country, :recipe_link, :recipe_title)
      user = User.find_by(api_key: api_key)
    end
  end
end
