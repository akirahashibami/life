class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @current_user = current_user
    @user = User.find(params[:id])
    @videos = @user.videos.order(id: "DESC").limit(4)
    @favo_videos = @user.favorites_videos.order(id: "DESC").limit(4)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def favorites
    @user = User.find(params[:id])
    @current_user = current_user
    @favorites = @user.favorites_videos
  end

  def videos
    @current_user = current_user
    @user = User.find(params[:id])
    @user_videos = @user.videos
  end

  def follows
    @current_user = current_user
    @user = User.find(params[:id])
    @users = @user.followings.where(release_status: 1)
  end

  def followers
    @current_user = current_user
    @user = User.find(params[:id])
    @users = @user.followers.where(release_status: 1)
  end

  def withdraw
    # code
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :release_status, :deleted_status)
  end

end
