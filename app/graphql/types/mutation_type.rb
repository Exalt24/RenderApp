# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_link, mutation: Mutations::CreateLink
    field :create_vote, mutation: Mutations::CreateVote
    field :signin_user, mutation: Mutations::SignInUser
  end
end
