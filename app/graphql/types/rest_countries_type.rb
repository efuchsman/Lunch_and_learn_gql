
module Types
  class RestCountriesType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :capital, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
