class Event < ApplicationRecord
  belongs_to :venue, optional: true
  has_many :rsvps, dependent: :destroy
end
