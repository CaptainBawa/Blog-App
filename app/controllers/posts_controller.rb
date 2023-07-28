class PostsController < ApplicationController
  # The index function retrieves a user and their posts, and initializes a new post object.
  def index
    @user = User.find(params[:author_id])
    @posts = @user.posts
    @post = Post.new
  end

  # The function assigns variables for a post, comment, like, and user in order
  # to display them in a view.
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
    @user = current_user
  end

  # The `create` function creates a new post and associates it with the current user,
  # then redirects to the user's posts page if successful, or renders the index page
  # with the user's posts if there are errors.
  def create
    @user = current_user
    @post = Post.new(post_params.merge(author_id: @user.id))
    if @post.save
      @post.update_posts_counter
      redirect_to user_posts_path(@user), notice: 'Post created successfully.'
    else
      @posts = @user.posts
      render :index
    end
  end

  private

  # The function `post_params` is used to extract and permit specific parameters from
  # the `params` object in a Ruby on Rails application.
  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end
end
