class UsersController < ApplicationController
  # The index function retrieves all users from the database.
  def index
    @users = User.all
  end

  # The function retrieves a user object from the database
  # based on the provided ID.
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
