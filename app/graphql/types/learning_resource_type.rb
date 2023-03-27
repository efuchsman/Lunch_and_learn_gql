module Types
  class LearningResourceType < Types::BaseObject
    field :country, String
    field :video, Types::VideoType, null: true
    field :images, [Types::ImageType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
