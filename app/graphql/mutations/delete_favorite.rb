module Mutations
  class DeleteFavorite < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :api_key, String, required: true

    field :success, String, null: true

    def resolve(id:, api_key:)
      user = User.find_by(api_key: api_key)

      if user.nil?
        raise GraphQL::ExecutionError, "No User found with the apiKey provided"
      end

      favorite = Favorite.find_by(id: id)

      if favorite.nil?
        raise GraphQL::ExecutionError, "No Favorite found with the ID provided"
      end

      favorite.destroy
      { success: "Favorite successfully deleted" }
    end
  end
end
