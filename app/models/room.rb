class Room < ApplicationRecord

  # パスワード設定用
  has_secure_password validations: true

  validates :room_name, presence: true

  has_many :room_messages,      dependent: :destroy
  has_many :room_videos,        dependent: :destroy
  has_many :room_users,         dependent: :destroy
end
