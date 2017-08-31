module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :viewer do
      description "Takes a JSON web token as an argument to authenticate queries"
      argument :token, types.String
      type Types::QueryViewerType

      resolve -> (query, args, context) {
        return context[:current_user] if context[:current_user].present?
        current_user = context[:authorize_api_req].call({ Authorization: args[:token] }).result || User.new
        context[:current_user] = current_user
      }
    end
  end
end
