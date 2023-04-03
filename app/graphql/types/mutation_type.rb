module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_favorite, mutation: Mutations::CreateFavorite
    field :delete_favorite, mutation: Mutations::DeleteFavorite
  end
end
