class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'users_id'
  belongs_to :post, foreign_key: 'posts_id'

  # The function `update_post_comments_counter` increments the
  # `CommentsCounter` attribute of a post.
  def update_post_comments_counter
    post.increment!(:comments_counter)
  end
end

# Code to verify if the update_post_comments_counter method is working
# comment = Comment.first
# comment.update_post_comments_counter
