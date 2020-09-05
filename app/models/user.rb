class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :videos,             dependent: :destroy
  has_many :comments,           dependent: :destroy
  has_many :favorites,          dependent: :destroy
  has_many :likes,              dependent: :destroy

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

  # Userがfollow済みかどうか判定
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end


end
