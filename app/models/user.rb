class User < ApplicationRecord
  # The line `devise :database_authenticatable, :registerable, :recoverable, :rememberable,
  # :validatable, :confirmable` is configuring the Devise gem for the User model.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments, foreign_key: 'users_id'
  # counter_cache makes sure Rails automatically update the PostCounter
  # attribute in the User model when posts are created or destroyed.
  has_many :posts, foreign_key: 'author_id', counter_cache: true
  has_many :likes, foreign_key: 'users_id'

  # The code `validates :Name, presence: true` is validating that the `Name`
  # attribute of the `User` model is present, meaning it cannot be blank or nil.
  validates :name, presence: true
  # is adding a validation to the `User` model. It ensures that the `PostCounter` attribute is a
  # numerical value and that it is greater than or equal to 0. This means that the `PostCounter`
  # attribute cannot be a non-integer value or a negative number.
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # The function retrieves the three most recent posts written
  # by the author.
  def three_most_recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end
end

# Code to verify if the three_most_recent_posts method is working
# user = User.find_by(Name: "Kwame")
# user.three_most_recent_posts
