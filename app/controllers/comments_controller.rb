class CommentsController < ApplicationController

  def create
    video               = Video.find(params[:video_id])
    @comments           = video.comments.order(id: "DESC").page(params[:page]).per(8)
    @comment            = Comment.new(comment_params)
    @comment.user_id    = current_user.id
    @comment.video_id   = params[:video_id]
    @comment.save
    @video = @comment.video
    @video.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    video               = Video.find(params[:video_id])
    @comments           = video.comments.order(id: "DESC")
    @comment = Comment.find_by(id: params[:id], video_id: params[:video_id])
    @comment.destroy
    # redirect_back(fallback_location: videos_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
