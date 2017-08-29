class Event < ApplicationRecord
  belongs_to :venue, optional: true
  has_many :rsvps, dependent: :destroy

  accepts_nested_attributes_for :venue, :rsvps
end
