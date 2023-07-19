class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'author_id'
    has_many :comments
    has_many :likes

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