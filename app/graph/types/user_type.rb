module Types
  UserType = GraphQL::ObjectType.define do
    name "User"

    field :id, types.Int
    field :first_name, types.String
    field :last_name, types.String
    field :email, types.String
    field :phone, types.String
    field :max_party_size, types.Int
    field :admin, types.Boolean, description: "Admins have full read/write access"

    field :rsvps do
      type types[Types::RsvpType]

      resolve -> (user, args, context) {
        user.rsvps
      }
    end

    field :updated_at do
      type types.Int

      resolve -> (user, args, context) {
        user.updated_at.to_i
      }
    end

    field :created_at do
      type types.Int

      resolve -> (user, args, context) {
        user.created_at.to_i
      }
    end
  end
end
