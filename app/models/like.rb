class Like < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :post, foreign_key: 'posts_id'

  # The function `update_post_likes_counter` increments the `likes_counter`
  # attribute of a post.
  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
# Code to verify if the update_post_comments_counter method is working
# Like.create(users_id: user.id, posts_id: post.id)
# like = Like.first
# like.update_post_likes_counter
