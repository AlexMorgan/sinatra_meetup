class Meetup < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_many :comments
end
