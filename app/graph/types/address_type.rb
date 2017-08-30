module Types
  AddressType = GraphQL::ObjectType.define do
    name "Address"

    field :id, types.Int
    field :street, types.String, description: "Door number, building name, street name"
    field :city, types.String
    field :postcode, types.String, description: "Also known as a zip code 🇺🇸"
    field :country, types.String
    field :lat, types.String
    field :lng, types.String

    field :updated_at do
      type types.Int

      resolve -> (address, args, context) {
        address.updated_at.to_i
      }
    end

    field :created_at do
      type types.Int

      resolve -> (address, args, context) {
        address.created_at.to_i
      }
    end
  end
end
