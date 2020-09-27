class VideosController < ApplicationController

  require 'miyabi'

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.title.is_hira? || @video.title.is_kana?
      @video.conversion_title = @video.title.to_roman
    else
      @video.conversion_title = @video.title.to_kanhira.to_roman
    end
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
    @comments   = @video.comments.order(id: "DESC").page(params[:page]).per(8).includes(:user)
  end

  def index
    @videos = Video.order(id: "DESC").page(params[:page]).per(12).includes(:user)
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

  def search
    word = params[:search]
    unless word.blank?
      if word.is_hira? || word.is_kana?
        conversion_word = word.to_roman
      elsif word.is_roman?
        conversion_word = word
      elsif !word.is_japanese?
        flash[:notice] = '検索ワードは日本語を入力してください'
        redirect_back(fallback_location: root_path)
      else
        conversion_word = word.to_kanhira.to_roman
      end
    end
    @search_video = Video.search(conversion_word).order(id: "DESC").page(params[:page]).per(12).includes(:user)
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
