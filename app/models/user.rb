class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :videos,             dependent: :destroy
  has_many :comments,           dependent: :destroy
  has_many :favorites,          dependent: :destroy
  has_many :likes,              dependent: :destroy
  has_many :favorites_videos,   dependent: :destroy,  through: :favorites,  source: :video

end
