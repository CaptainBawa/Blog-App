class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  # The dependent: :destroy ensures that when a post is deleted, its
  # associated likes and comments will also be deleted.
  has_many :comments, foreign_key: 'posts_id', dependent: :destroy
  has_many :likes, dependent: :destroy

  # The function updates the PostCounter attribute of a user by counting
  # the number of posts they have.
  def update_posts_counter
    user.update(PostCounter: user.posts.count)
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
