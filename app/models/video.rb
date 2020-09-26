class Video < ApplicationRecord

  require 'miyabi'

  # ActiveStorage
  has_one_attached :video
  validate :video_type

  validates :video,           presence: true
  validates :title,           presence: true
  validates :introduction,    presence: true

  has_many :favorites,        dependent: :destroy
  has_many :comments,         dependent: :destroy
  has_many :likes,            dependent: :destroy

  has_many :notifications,    dependent: :destroy

  belongs_to :user

  # すでにお気に入りされているかどうか調べるメソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # すでにいいねされているかどうか調べるメソッド
  def liked_by?(user)
    self.likes.exists?(user_id: user.id)
  end

  # ActiveStorage画像リサイズメソッド
  def thumbnail
    profile_image.variant(resize: '100x100').processed
  end

  def video_type
    if video.attached? && !video.content_type.in?(%("video/mp4"))
      errors.add(:video, 'の拡張子はmp4で選択してください')
    elsif !video.attached?
      errors.add(:video, "ファイルを添付してください")
    end
  end

  # いいねした時に通知がされるメソッド
  def create_notification_like!(current_user)
    # すでにいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and video_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    # いいねされてない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        video_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は通知済とする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメントが投稿された時に通知がされるメソッド
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(video_id: id).where.not(user_id: current_user.id).distinct
    # selectメソッド...取得したい列を指定するメソッド(今回は:user_id)
    # distinctメソッド...重複レコードを１つにまとめるためのメソッド
    # まず、投稿にコメントしているユーザーのIDリストを取得、自分のコメントは除外、重複した場合は削除する。
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # 投稿者にも通知を送る
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回投稿することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      video_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は通知済とする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # フォローされた時に通知がされるメソッド
  def create_notification_follow!(current_user)
    # 同じ通知レコードが存在しない時だけ、レコードを作成
    temp = Notification.where(["visitor_id = ? and Visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # 検索機能
  def self.search(search)
    return Video.all unless search
    Video.where(['conversion_title LIKE?', "%#{search}%"])
  end

end
