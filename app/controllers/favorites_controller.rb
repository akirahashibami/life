class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.build(video_id: params[:video_id])
    favorite.save
    redirect_back(fallback_location: videos_path)
  end

  def destroy
    Favorite.find_by(video_id: params[:video_id], user_id: current_user).destroy
    redirect_back(fallback_location: videos_path)
  end

end
