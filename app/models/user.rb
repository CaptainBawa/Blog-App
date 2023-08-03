class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :comments, foreign_key: 'users_id'
  # counter_cache makes sure Rails automatically update the PostCounter
  # attribute in the User model when posts are created or destroyed.
  has_many :posts, foreign_key: 'author_id', counter_cache: true
  has_many :likes, foreign_key: 'users_id'

  # The code `validates :Name, presence: true` is validating that the `Name`
  # attribute of the `User` model is present, meaning it cannot be blank or nil.
  validates :name, presence: true
  # validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # The function retrieves the three most recent posts written
  # by the author.
  def three_most_recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end
end

# Code to verify if the three_most_recent_posts method is working
# user = User.find_by(Name: "Kwame")
# user.three_most_recent_posts
