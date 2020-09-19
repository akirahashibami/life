class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name,      presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :videos,             dependent: :destroy
  has_many :comments,           dependent: :destroy
  has_many :favorites,          dependent: :destroy
  has_many :likes,              dependent: :destroy
  has_many :room_messages,      dependent: :destroy
  has_many :room_videos,        dependent: :destroy
  has_many :room_users,         dependent: :destroy

  has_many :room, through: :room_users

  # ユーザーのお気に入りした動画を取得する
  # 下記はfavoritesを通してvideoから情報を集めている
  has_many :favorites_videos,   dependent: :destroy,  through: :favorites,  source: :video


  # フォロー・フォロワーの情報を集める
  # has_many :relatinshipだと２通り書かなくてはならず名前被りが起こるので中間テーブル名を再定義する

  # ============ 自分がフォローしているユーザーとの関連 ===============
  has_many :active_relationships,   class_name: "Relationship",   foreign_key: :following_id
  has_many :followings,   through: :active_relationships,    source: :follower
  # ============================================================

  # ============ 自分がフォローされるユーザーとの関連 ===============
  has_many :passive_relationships,  class_name: "Relationship",   foreign_key: :follower_id
  has_many :followers,    through: :passive_relationships,   source: :following
  # ===========================================================


  # 通知機能用の記述
  # 自分からの通知
  has_many  :active_notifications,  class_name: 'Notification',  foreign_key: 'visitor_id',  dependent: :destroy
  # 相手からの通知
  has_many  :passive_notifications, class_name: 'Notification',  foreign_key: 'visited_id',  dependent: :destroy

  # Userがfollow済みかどうか判定
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  # ActiveStorage画像リサイズメソッド
  def thumbnail
    return self.profile_image.variant(resize: '150x150').processed
  end

  # フォローされた時に通知がされるメソッド
  def create_notification_follow!(current_user)
    # 同じ通知レコードが存在しない時だけ、レコードを作成
    temp = Notification.where(["visitor_id = ? and Visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id:   id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
