module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_favorite, mutation: Mutations::CreateFavorite
  end
end
