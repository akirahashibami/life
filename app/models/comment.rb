class Comment < ApplicationRecord

  validates :comment, presence: true

  has_many  :notifications, dependent: :destroy

  belongs_to :user
  belongs_to :video
end
