class RoomVideo < ApplicationRecord
  has_one_attached :room_video
  validate :video_type

  belongs_to :room
  belongs_to :user

  def video_type
    if room_video.attached? && !room_video.content_type.in?(%("room_video/mp4"))
      errors.add(:room_video, 'の拡張子はmp4で選択してください')
    elsif !room_video.attached?
      errors.add(:room_video, "ファイルを添付してください")
    end
  end
end
