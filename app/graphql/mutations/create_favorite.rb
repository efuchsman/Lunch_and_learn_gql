module Mutations
  class CreateFavorite < Mutations::BaseMutation
    argument :params, Types::FavoriteInputType, required: true
    argument :api_key, String, required: true

    field :favorite, Types::FavoriteType, null: false

    field :success, String, null: true

    def resolve(params:, api_key:)
      favorite_params = Hash params

      begin
        user = User.find_by(api_key: api_key)
        if user.nil?
          raise GraphQL::ExecutionError, "No User found with the apiKey provided"
        end

        favorite = user.favorites.create!(favorite_params)
        { favorite: favorite, success: "New favorite created" }


      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
