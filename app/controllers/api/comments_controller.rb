class Api::CommentsController < ApplicationController
  def index
    @comments = Comment.all
    render json: @comments
  end

  def create
    @comment = Comment.new(
      text: comment_params[:text],
      users_id: comment_params[:users_id]
    )
    if @comment.save
      @comment.update_post_comments_counter
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :users_id)
  end
end
