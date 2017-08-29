module Api::V1
  class VenueSerializer < ActiveModel::Serializer
    attributes :id, :name, :address_id, :description, :url
  end
end
