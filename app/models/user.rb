class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes

  attribute :name, type: String
  attribute :bio, type: Text
  attribute :photo, type: String
  attribute :posts_counter, type: Integer, default: 0
end
