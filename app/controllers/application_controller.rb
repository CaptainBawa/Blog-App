class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # The current_user function returns the first user object and assigns it
  # to the instance variable @current_user if it is not already assigned.
  def current_user
    @current_user ||= User.first
  end
end
