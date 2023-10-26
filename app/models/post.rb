class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  attribute :title, :string
  attribute :text, :text
  attribute :likes_count, :integer, default: 0
  attribute :comments_count, :integer, default: 0
end
