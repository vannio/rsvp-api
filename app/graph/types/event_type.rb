module Types
  EventType = GraphQL::ObjectType.define do
    name "Event"

    field :id, types.Int
    field :title, types.String
    field :venue_id, types.Int
    field :venue, Types::VenueType

    field :datetime do
      type types.String

      resolve -> (event, args, context) {
        event.datetime.try(:iso8601)
      }
    end

    field :rsvps do
      type types[Types::RsvpType]

      resolve -> (event, args, context) {
        context[:current_user].try(:admin) ? event.rsvps : GraphQL::ExecutionError.new(context[:auth_error_msg])
      }
    end

    field :updated_at do
      type types.Int

      resolve -> (event, args, context) {
        event.updated_at.to_i
      }
    end

    field :created_at do
      type types.Int

      resolve -> (event, args, context) {
        event.created_at.to_i
      }
    end
  end
end
