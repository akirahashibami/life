class RoomVideosController < ApplicationController

  def create
    @room_video = RoomVideo.new(room_video_params)
    @room_video.user_id = current_user.id
    @room_video.room_id = params[:room_id]
    if @room_video.save!
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private

  def room_video_params
    params.require(:room_video).permit(:video)
  end
end
