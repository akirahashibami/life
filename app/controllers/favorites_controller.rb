class FavoritesController < ApplicationController
  def create
    @video = Video.find(params[:video_id])
    favorite = current_user.favorites.build(video_id: params[:video_id])
    favorite.save
    # redirect_back(fallback_location: videos_path)
  end

  def destroy
    @favorites = current_user.favorites_videos
    @video = Video.find(params[:video_id])
    Favorite.find_by(video_id: params[:video_id], user_id: current_user).destroy
    # redirect_back(fallback_location: videos_path)
  end
end
