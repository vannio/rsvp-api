module Types
  VenueType = GraphQL::ObjectType.define do
    name "Venue"

    field :id, types.Int
    field :address_id, types.Int
    field :address, Types::AddressType
    field :name, types.String
    field :description, types.String
    field :url, types.String

    field :updated_at do
      type types.Int

      resolve -> (venue, args, context) {
        venue.updated_at.to_i
      }
    end

    field :created_at do
      type types.Int

      resolve -> (venue, args, context) {
        venue.created_at.to_i
      }
    end
  end
end
