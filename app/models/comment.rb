class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  attribute :text, :text

  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
