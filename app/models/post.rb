class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  # The dependent: :destroy ensures that when a post is deleted, its
  # associated likes and comments will also be deleted.
  has_many :comments, foreign_key: 'posts_id', dependent: :destroy
  has_many :likes, foreign_key: 'posts_id', dependent: :destroy

  # The line `validates :Title, presence: true, length: {maximum: 250}` is a
  # validation rule for the `Title` attribute of the `Post` model.
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # The function updates the PostCounter attribute of a user by counting
  # the number of posts they have. If there are no posts, it sets the counter to 0.
  def update_posts_counter
    post_count = user.posts.count
    user.update(post_counter: post_count.zero? ? 0 : post_count)
  end

  # The function returns the five most recent comments in descending order
  # of their creation time.
  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
# Code to verify if the update_post_comments_counter method is working
# post = Post.first
# post.update_posts_counter
# post.five_most_recent_comments
