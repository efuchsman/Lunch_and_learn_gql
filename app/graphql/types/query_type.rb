module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :rest_countries, [RestCountriesType], null: false

    field :random_rest_country, RestCountriesType, null: false

    def rest_countries
      RestCountriesFacade.all_countries
    end

    def random_rest_country
      RestCountriesFacade.random_country
    end
  end
end
