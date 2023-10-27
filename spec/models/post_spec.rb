require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Happy New Year', author: User.create(name: 'Raihan')) }

  before { subject.save }

  describe 'validation tests' do
    # ... existing validation tests ...

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
      subject.comments_counter = 0
      expect(subject).to be_valid
    end

    it 'likes_counter should be integer' do
      subject.likes_counter = 'Whats up'
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to zero' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
      subject.likes_counter = 0
      expect(subject).to be_valid
    end
  end

  describe '#update_user_posts_counter' do
    it 'updates the user posts_counter attribute' do
      user = User.create(name: 'Sintheys')
      post = Post.create(title: 'Good morning', author: user)

      post.update_user_posts_counter

      expect(user.reload.post_counter).to eq(0)
    end
  end

  describe '#five_most_recent_comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'Sintheys')
      post = Post.create(title: 'Good morning', author: user)

      Comment.create(user:, post:, text: 'comment 1', created_at: 5.days.ago)
      comment2 = Comment.create(user:, post:, text: 'comment 2', created_at: 4.days.ago)
      comment3 = Comment.create(user:, post:, text: 'comment 3', created_at: 3.days.ago)
      comment4 = Comment.create(user:, post:, text: 'comment 4', created_at: 2.days.ago)
      comment5 = Comment.create(user:, post:, text: 'comment 5', created_at: 1.day.ago)
      comment6 = Comment.create(user:, post:, text: 'comment 6', created_at: Time.now)

      expect(post.five_most_recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end
end
