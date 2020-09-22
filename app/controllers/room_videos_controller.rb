class RoomVideosController < ApplicationController

  def create
    unless params[:room_video].nil?
      @room_video = RoomVideo.new(room_video_params)
      @room_video.user_id = current_user.id
      @room_video.room_id = params[:room_id]
      if @room_video.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private

  def room_video_params
    params.require(:room_video).permit(:room_video)
  end
end
