module Types
  class VideoType < Types::BaseObject
    field :youtube_video_id, ID, null: false
    field :title, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
