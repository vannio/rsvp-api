module Api::V1
  class EventSerializer < ActiveModel::Serializer
    attributes :id, :title, :datetime, :venue_id
  end
end
