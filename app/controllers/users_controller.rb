class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @videos = @user.videos.order(id: "DESC").limit(4)
    @favo_videos = @user.favorites_videos.order(id: "DESC").limit(4)
  end

  def edit
    # code
  end

  def update
    # code
  end

  def favorites
    # code
  end

  def videos
    @user = User.find(params[:id])
    @user_videos = @user.videos
  end

  def withdraw
    # code
  end

  private

end
