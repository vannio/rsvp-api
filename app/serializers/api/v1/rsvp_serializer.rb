module Api::V1
  class RsvpSerializer < ActiveModel::Serializer
    attributes :id, :event_id, :user_id, :responded?, :adults, :children, :comments
  end
end
