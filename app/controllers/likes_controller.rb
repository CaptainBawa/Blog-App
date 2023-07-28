class LikesController < ApplicationController
  # The function creates a like for a post and updates the post's like counter.
  def create_like
    @post = Post.find(params[:id])
    @like = current_user.likes.build(like_params.merge(posts_id: @post.id))
    if @like.save
      @like.update_post_likes_counter
      redirect_to user_post_path(@post), notice: 'Post liked successfully.'
    else
      render :show
    end
  end

  private

  # The function `like_params` is used to permit specific parameters for the
  # `like` object in a Ruby on Rails application.
  def like_params
    params.require(:like).permit(:users_id, :posts_id)
  end
end
