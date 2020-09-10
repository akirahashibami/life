class Room < ApplicationRecord

  validates :room_name,         presence: true

  has_many :room_messages,      dependent: :destroy
  has_many :room_videos,        dependent: :destroy
  has_many :room_users,         dependent: :destroy

  has_many :user, through: :room_users
end
