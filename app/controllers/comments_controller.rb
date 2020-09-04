class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.video_id = params[:video_id]
    @comment.save
    redirect_back(fallback_location: videos_path)
  end

  def destroy
    comment = Comment.find_by(id: params[:id], video_id: params[:video_id])
    comment.destroy
    redirect_back(fallback_location: videos_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
