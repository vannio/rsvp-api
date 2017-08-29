class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def responded?
    self.created_at < self.updated_at
  end

  alias responded responded?
end
