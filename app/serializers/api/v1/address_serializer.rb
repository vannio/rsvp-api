module Api::V1
  class AddressSerializer < ActiveModel::Serializer
    attributes :id, :street, :city, :postcode, :country, :lat, :lng
  end
end
