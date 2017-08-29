class Venue < ApplicationRecord
  belongs_to :address
  has_many :events, dependent: :destroy

  accepts_nested_attributes_for :address, :events
end
