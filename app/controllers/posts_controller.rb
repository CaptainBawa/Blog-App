class PostsController < ApplicationController

    # The index function retrieves all posts belonging to a
    # specific user.
    def index
        @user = User.find(params[:author_id])
        @posts = @user.posts
      end

    # The function retrieves a specific post from the database
    # and assigns it to the instance variable @post.
    def show 
        @post = Post.find(params[:id])
    end
end