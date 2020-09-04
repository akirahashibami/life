class UsersController < ApplicationController

  def show

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
