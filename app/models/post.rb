class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  attribute :title, :string
  attribute :text, :text
  attribute :likes_count, :integer, default: 0
  attribute :comments_count, :integer, default: 0

  after_save :update_user_post_counter

  private

  def update_user_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
