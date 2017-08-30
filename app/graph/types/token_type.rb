module Types
  TokenType = GraphQL::ObjectType.define do
    name "Token"
    description "Authentication token for Viewer"

    field :result, types.String
  end
end
