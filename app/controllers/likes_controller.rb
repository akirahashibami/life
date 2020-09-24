class LikesController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    like = current_user.likes.build(video_id: params[:video_id])
    like.save
    @video.create_notification_like!(current_user)
    # redirect_back(fallback_location: videos_path)
  end

  def destroy
    @video = Video.find(params[:video_id])
    Like.find_by(video_id: params[:video_id], user_id: current_user).destroy
    # redirect_back(fallback_location: videos_path)
  end
end
