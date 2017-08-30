module Types
  MutationType = GraphQL::ObjectType.define do
    name "Mutation"

    field :createToken, Types::TokenType do
      description "Authenticates a user"
      argument :email, !types.String
      argument :password, !types.String

      resolve -> (obj, args, ctx) {
        ctx[:authenticate_user].call(args[:email], args[:password])
      }
    end
  end
end
