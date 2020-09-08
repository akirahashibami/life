class Video < ApplicationRecord

  validates :video,           presence: true
  validates :title,           presence: true
  validates :introduction,    presence: true

  # ActiveStorage
  has_one_attached :video
  validate :video_type

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

  def video_type
    if video.attached? && !video.content_type.in?(%("video/mp4"))
      errors.add(:video, '拡張子はmp4で選択してください')
    elsif !video.attached?
      errors.add(:video, "ファイルを添付してください")
    end
  end

end
