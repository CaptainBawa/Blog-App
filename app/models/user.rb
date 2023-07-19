class User < ApplicationRecord
    has_many :comments
    # counter_cache makes sure Rails automatically update the PostCounter
    # attribute in the User model when posts are created or destroyed.
    has_many :posts, counter_cache: true
    has_many :likes

    # The function retrieves the three most recent posts written 
    # by the author.
    def three_most_recent_posts
        posts = Post.where(author_id: self.id).order(created_at: :desc).limit(3)
    end
end

# Code to verify if the three_most_recent_posts method is working
# user = User.find_by(Name: "Kwame")
# user.three_most_recent_posts
