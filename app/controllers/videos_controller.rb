class VideosController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.save
      redirect_to video_path(@video)
    else
      render :new
    end
  end

  def show
    @video      = Video.find(params[:id])
    @user       = current_user
    @comment    = Comment.new
    @comments   = @video.comments.order(id: "DESC").page(params[:page]).per(8)
  end

  def index
    @videos = Video.order(id: "DESC").page(params[:page]).per(12)
    @user = current_user
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      redirect_to @video
    elsif
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to user_path(current_user)
  end

  private

  # 動画投稿ユーザー以外はURL直打ちで編集に遷移できないようにする
  def ensure_correct_user
    video = Video.find(params[:id])
      unless video.user == current_user
        redirect_back(fallback_location: videos_path)
      end
  end

  def video_params
    params.require(:video).permit(:title, :introduction, :video)
  end
end
