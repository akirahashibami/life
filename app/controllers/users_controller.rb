class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

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
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
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
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end

  private

  # ログイン中ユーザー以外のユーザー情報を直接編集できないようにする
  def ensure_correct_user
    user = User.find(params[:id])
      unless user == current_user
        redirect_back(fallback_location: user_path(current_user))
      end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :release_status, :deleted_status)
  end

end
