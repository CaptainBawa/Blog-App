class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'author_id'
    has_many :comments
    has_many :likes
end