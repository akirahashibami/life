class RoomVideo < ApplicationRecord

  has_one_attached :video
  validate :video_type

  belongs_to :room
  belongs_to :user

  def video_type
    if video.attached?
      if !video.content_type.in?(%("room_video/mp4"))
        errors.add(:video, 'の拡張子はmp4で選択してください')
      end
    else
      errors.add(:video, "ファイルを添付してください")
    end
  end

end
