class Event < ApplicationRecord
  belongs_to :venue
  has_many :rsvps, dependent: :destroy
end
