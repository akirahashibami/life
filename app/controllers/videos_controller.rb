class VideosController < ApplicationController

  before_action :authenticate_user!

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    @video.save
    redirect_to video_path(@video)
  end

  def show
    @video      = Video.find(params[:id])
    @user       = current_user
    @comment    = Comment.new
    @comments   = @video.comments
  end

  def index
    @videos = Video.order(id: "DESC")
    @user = current_user
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    @video.update(video_params)
    redirect_to @video
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to user_path(current_user)
  end

  private

  def video_params
    params.require(:video).permit(:title, :introduction, :video)
  end
end
