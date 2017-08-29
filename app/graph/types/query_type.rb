module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"

    field :user do
      argument :id, !types.ID
      type Types::UserType
      resolve ->(obj, args, ctx) { User.find(args[:id]) }
    end
    field :users do
      type types[Types::UserType]
      resolve ->(obj, args, ctx) { User.all }
    end
    field :event do
      argument :id, !types.ID
      type Types::EventType
      resolve ->(obj, args, ctx) { Event.find(args[:id]) }
    end
    field :events do
      type types[Types::EventType]
      resolve ->(obj, args, ctx) { Event.all }
    end
  end
end
