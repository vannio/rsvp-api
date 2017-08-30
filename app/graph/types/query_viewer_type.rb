module Types
  QueryViewerType = GraphQL::ObjectType.define do
    name "QueryViewer"

    field :user do
      description "Not passing an id argument will return the logged-in user by default"
      argument :id, types.ID
      type Types::UserType

      resolve -> (current_user, args, context) {
        return current_user unless args[:id].present?
        current_user_or_admin = current_user.try(:admin) || args[:id] == current_user.try(:id).to_s
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user_or_admin
        User.find(args[:id])
      }
    end

    field :users do
      type types[Types::UserType]

      resolve -> (current_user, args, context) {
        return GraphQL::ExecutionError.new(context[:auth_error_msg]) unless current_user.admin
        User.all
      }
    end

    field :event do
      argument :id, !types.ID
      type Types::EventType

      resolve -> (current_user, args, context) {
        Event.find(args[:id])
      }
    end

    field :events do
      type types[Types::EventType]

      resolve -> (current_user, args, context) {
        Event.all
      }
    end
  end
end
