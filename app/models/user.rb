class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes

  attribute :name, type: String
  attribute :bio, :text
  attribute :photo, :string
  attribute :posts_counter, :integer, default: 0

  def three_must_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
