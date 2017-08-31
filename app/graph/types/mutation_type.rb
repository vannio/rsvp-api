module Types
  MutationType = GraphQL::ObjectType.define do
    name "Mutation"

    field :createAuthToken, Types::TokenType do
      description "Creates a JSON web token which can be used to authenticate queries"
      argument :email, !types.String
      argument :password, !types.String

      resolve -> (mutation, args, context) {
        context[:authenticate_user].call(args[:email], args[:password])
      }
    end
  end
end
