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

  # The function creates a comment for a post and updates the comment counter for the post.
  def create_comment
    @post = Post.find(params[:id])
    @comment = current_user.comments.build(comment_params.merge(post: @post))
    if @comment.save
      @comment.update_post_comments_counter
      redirect_to user_post_path(@post), notice: 'Comment added successfully.'
    else
      render :show
    end
  end

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

  # The function `post_params` is used to extract and permit specific parameters from
  # the `params` object in a Ruby on Rails application.
  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end

  # The function `comment_params` is used to extract and permit the `text` parameter
  # from the `comment` object in the `params` hash.
  def comment_params
    params.require(:comment).permit(:text)
  end

  # The function `like_params` is used to permit specific parameters for the
  # `like` object in a Ruby on Rails application.
  def like_params
    params.require(:like).permit(:users_id, :posts_id)
  end
end
