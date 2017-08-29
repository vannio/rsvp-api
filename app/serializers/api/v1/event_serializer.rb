module Api::V1
  class EventSerializer < ActiveModel::Serializer
    attributes :id, :title, :date, :time, :venue_id
  end
end
