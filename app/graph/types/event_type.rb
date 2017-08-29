module Types
  EventType = GraphQL::ObjectType.define do
    name "Event"

    field :id, types.Int
    field :title, types.String
    field :date, types.String
    field :time, types.String
    field :venue_id, types.Int
    field :venue, Types::VenueType
    field :rsvps do
      type types[Types::RsvpType]
      resolve -> (obj, args, ctx) {
        obj.rsvps
      }
    end
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
