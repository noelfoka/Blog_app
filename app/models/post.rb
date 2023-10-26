class Post < ApplicationRecord
  belongs_to :author, class_name: 'User',
  has_many :comments
  has_many :likes

  attribute :title, type: String
  attribute :text, type: Text
  attribute :likes_count, type: Integer, default: 0
  attribute :comments_count, type: Integer, default: 0
end