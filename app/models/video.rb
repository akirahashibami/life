class Video < ApplicationRecord

  validates :title,           presence: true
  validates :introduction     presence: true

  # ActiveStorage
  has_one_attached :video

  has_many :favorites,    dependent: :destroy
  has_many :comments,     dependent: :destroy
  has_many :likes,        dependent: :destroy

  belongs_to :user

  # すでにお気に入りされているかどうか調べるメソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # すでにいいねされているかどうか調べるメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # ActiveStorage画像リサイズメソッド
  def thumbnail
    return self.profile_image.variant(resize: '100x100').processed
  end

end
