module Types
  MutationType = GraphQL::ObjectType.define do
    name "Mutation"

    field :viewer do
      description "Takes a JSON web token as an argument to authenticate queries"
      argument :token, types.String
      type Types::MutationViewerType

      resolve -> (query, args, context) {
        current_user = context[:authorize_api_req].call({ Authorization: args[:token] }).result || User.new
        context[:current_user] = current_user
        current_user
      }
    end

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
