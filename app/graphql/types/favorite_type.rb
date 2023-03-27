module Types
  class FavoriteType < Types::BaseObject
    field :id, ID, null: false
    field :country, String
    field :recipe_title, String
    field :recipe_link, String
    field :user_id, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    delegate :user, to: :object
  end
end
