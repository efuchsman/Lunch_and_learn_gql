module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :rest_countries, [RestCountriesType], null: false

    field :random_rest_country, RestCountriesType, null: false

    field :recipes, [RecipeType], null: true do
      argument :country, String, required: true
    end

    def rest_countries
      RestCountriesFacade.all_countries
    end

    def random_rest_country
      RestCountriesFacade.random_country
    end

    def recipes(country:)
      RecipeFacade.recipes_by_country(country)
    end
  end
end
