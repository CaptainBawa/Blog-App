class User < ApplicationRecord
    has_many :comments
    has_many :posts
    has_many :likes

    def three_most_recent_posts
        posts = Post.where(author_id: self.id).order(created_at: :desc).limit(3)
    end
end

# Code to verify if the three_most_recent_posts method is working
# user = User.find_by(name: "John Doe")
# user.three_most_recent_posts
