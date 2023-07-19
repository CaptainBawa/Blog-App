class Comment < ApplicationRecord
    belongs_to :user, foreign_key: 'users_id'
    belongs_to :post, foreign_key: 'posts_id'
end