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
    case !params[:user][:name].blank?
      when true
        unless params[:user][:profile_image].nil?
          if !params[:user][:profile_image].content_type.in?(%('profile_image/jpeg profile_image/png'))
            flash.now[:error]="・jpegまたはpngファイルを添付してください"
            render :edit
          else
            @user.update(user_params)
            redirect_to user_path(@user)
          end
        else
          @user.update(user_params)
          redirect_to user_path(@user)
        end
      else
        flash.now[:error]="・ユーザーネームを入力して下さい"
        render :edit
      end
  end

  def favorites
    @user = User.find(params[:id])
    @current_user = current_user
    @favorites = @user.favorites_videos.page(params[:page]).per(5).includes(user: :videos)
  end

  def videos
    @current_user = current_user
    @user = User.find(params[:id])
    @user_videos = @user.videos.page(params[:page]).per(5).includes(:user)
  end

  def follows
    @current_user = current_user
    @user = User.find(params[:id])
    @users = @user.followings.where(release_status: 1).page(params[:page]).per(6)
  end

  def followers
    @current_user = current_user
    @user = User.find(params[:id])
    @users = @user.followers.where(release_status: 1).page(params[:page]).per(6)
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
