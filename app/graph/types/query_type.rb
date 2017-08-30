module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :viewer do
      argument :token, types.String
      type Types::ViewerType
      resolve -> (obj, args, ctx) {
        ctx[:authorize_api_req].call({ Authorization: args[:token] }).result || User.new
      }
    end
  end
end
