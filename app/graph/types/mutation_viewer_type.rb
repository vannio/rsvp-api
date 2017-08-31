module Types
  MutationViewerType = GraphQL::ObjectType.define do
    name "MutationViewer"

    user_fields = [:first_name, :last_name, :email]
    user_fields_with_types = {
      id: !types.ID,
      phone: types.String,
      max_party_size: types.Int,
      password: types.String
    }

    field :createUser, Types::UserType do
      user_fields.each { |k| argument k, !types.String }
      additional_fields = [:phone, :max_party_size, :password]
      user_fields_with_types.slice(*additional_fields).each_pair { |k,v| argument k, v }

      resolve -> (current_user, args, context) {
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user.admin
        user_attr = args.to_h.symbolize_keys.slice(*user_fields.concat(additional_fields))
        user = User.new(user_attr.compact)
        user.save ? user : GraphQL::ExecutionError.new(user.errors.full_messages.first)
      }
    end

    field :editUser, Types::UserType do
      user_fields.each { |k| argument k, types.String }
      user_fields_with_types.each_pair { |k,v| argument k,v }

      resolve -> (current_user, args, context) {
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user.admin
        user = User.find(args[:id])
        user_attr = args.to_h.symbolize_keys.slice(*user_fields.concat([:phone, :max_party_size, :password]))
        user if user.update(user_attr.compact)
        GraphQL::ExecutionError.new(user.errors.full_messages.first)
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
