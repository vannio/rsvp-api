module Types
  MutationViewerType = GraphQL::ObjectType.define do
    name "MutationViewer"

    field :createUser, Types::UserType do
      argument :first_name, !types.String
      argument :last_name, !types.String
      argument :email, !types.String
      argument :phone, types.String
      argument :max_party_size, types.Int
      argument :password, !types.String
      argument :password_confirmation, !types.String

      resolve -> (current_user, args, context) {
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user.admin
        user_attributes = args.to_h.symbolize_keys.slice(
          :first_name, :last_name, :email, :phone, :max_party_size, :password, :password_confirmation
        ).compact
        user = User.new(user_attributes)
        user.save ? user : GraphQL::ExecutionError.new(user.errors.full_messages.first)
      }
    end

    field :editUser, Types::UserType do
      argument :id, !types.ID
      argument :first_name, types.String
      argument :last_name, types.String
      argument :email, types.String
      argument :phone, types.String
      argument :max_party_size, types.Int
      argument :password, types.String
      argument :password_confirmation, types.String

      resolve -> (current_user, args, context) {
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user.admin
        user = User.find(args[:id])
        user_attributes = args.to_h.symbolize_keys.slice(
          :first_name, :last_name, :email, :phone, :max_party_size, :password, :password_confirmation
        ).compact
        user.update(user_attributes) ? user : GraphQL::ExecutionError.new(user.errors.full_messages.first)
      }
    end

    field :deleteUser, Types::UserType do
      argument :id, !types.ID

      resolve -> (current_user, args, context) {
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user.admin
        user = User.find(args[:id])
        user.destroy
      }
    end
  end
end
