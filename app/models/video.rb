class Video < ApplicationRecord

  # ActiveStorage
  has_one_attached :video

  belongs_to :user
end
