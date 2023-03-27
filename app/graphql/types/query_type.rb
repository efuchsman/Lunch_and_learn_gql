module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :rest_countries, [RestCountriesType], null: false

    field :random_rest_country, RestCountriesType, null: false

    field :recipes, [RecipeType], null: true do
      argument :country, String, required: true
    end

    field :learning_resource, LearningResourceType, null: true do
      argument :country, String, required: true
    end

    field :user, UserType, null: true do
      argument :api_key, String, required: true
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

    def learning_resource(country:)
      video = VideoFacade.country_video(country)
      images = ImageFacade.country_images(country)
      LearningResource.new(country.capitalize, video, images)
    end

    def user(api_key:)
      User.find_by(api_key: api_key)
    end
  end
end
