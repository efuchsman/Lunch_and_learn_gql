module Types
  class RecipeType < Types::BaseObject
    field :title, String
    field :url, String
    field :image, String
    field :country, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
