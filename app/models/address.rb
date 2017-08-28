class Address < ApplicationRecord
  has_many :venues
  has_many :users
end
