class PostsController < ApplicationController
  # The index function retrieves all posts belonging to a
  # specific user.
  def index
    @user = User.find(params[:author_id])
    @posts = @user.posts
    @post = Post.new
  end

  # The function retrieves a specific post from the database
  # and assigns it to the instance variable @post.
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
    @user = current_user
  end

  def create
    @user = current_user
    @post = Post.new(post_params.merge(author_id: @user.id))
    if @post.save
      @post.update_posts_counter
      redirect_to user_posts_path(@user), notice: "Post created successfully."
    else
      @posts = @user.posts
      render :index
    end
  end

  def create_comment
    @post = Post.find(params[:id])
    @comment = current_user.comments.build(comment_params.merge(post: @post))
    if @comment.save
      @comment.update_post_comments_counter
      redirect_to user_post_path(@post), notice: "Comment added successfully."
    else
      render :show
    end
  end

  def create_like
    @post = Post.find(params[:id])
    @like = current_user.likes.build(like_params.merge(posts_id: @post.id))
    if @like.save
      @like.update_post_likes_counter
      redirect_to user_post_path(@post), notice: "Post liked successfully."
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def like_params
    params.require(:like).permit(:users_id, :posts_id)
  end
end
