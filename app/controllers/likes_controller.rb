class LikesController < ApplicationController

  def create
    like = current_user.likes.build(video_id: params[:video_id])
    like.save
    redirect_back(fallback_location: videos_path)
  end

  def destroy
    Like.find_by(video_id: params[:video_id], user_id: current_user).destroy
    redirect_back(fallback_location: videos_path)
  end

end
