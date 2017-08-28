class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
        #  :recoverable, :rememberable, :trackable, :validatable

  belongs_to :address, optional: true
  has_many :rsvps, dependent: :destroy
  has_many :events, through: :rsvps

  accepts_nested_attributes_for :address, :rsvps

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :first_name, :last_name, format: {
    with: /[a-zA-Z]+/, message: "Only letters are accepted"
  }
end
