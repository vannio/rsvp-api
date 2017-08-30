module Types
  ViewerType = GraphQL::ObjectType.define do
    name "Viewer"

    field :user do
      description "No ID argument will return the logged-in user by default"
      argument :id, types.ID
      type Types::UserType
      resolve -> (obj, args, ctx) { args[:id].present? ? User.find(args[:id]) : obj }
    end
    field :users do
      type types[Types::UserType]
      resolve -> (obj, args, ctx) { obj.admin ? User.all : GraphQL::ExecutionError.new("Not Authorized") }
    end
    field :event do
      argument :id, !types.ID
      type Types::EventType
      resolve -> (obj, args, ctx) { Event.find(args[:id]) }
    end
    field :events do
      type types[Types::EventType]
      resolve -> (obj, args, ctx) { Event.all }
    end
  end
end
