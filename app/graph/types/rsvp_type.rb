module Types
  RsvpType = GraphQL::ObjectType.define do
    name "Rsvp"

    field :id, types.Int
    field :event_id, types.Int
    field :event, Types::EventType
    field :user_id, types.Int
    field :user, Types::UserType
    field :responded, types.Boolean
    field :adults, types.Int
    field :children, types.Int
    field :comments, types.String
    field :updated_at do
      type types.Int

      resolve -> (obj, args, ctx) {
        obj.updated_at.to_i
      }
    end
    field :created_at do
      type types.Int

      resolve -> (obj, args, ctx) {
        obj.created_at.to_i
      }
    end
  end
end
