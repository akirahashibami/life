class RoomMessage < ApplicationRecord

  validates :message,    presence: true

  belongs_to :room
  belongs_to :user
end
