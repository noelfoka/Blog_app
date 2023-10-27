require 'rails_helper'

RSpec.describe Like, type: :model do
  before :all do
    @user = User.create(name: 'Lily')
    @post = Post.create(author: @user, title: 'Title')
  end

  context '#create' do
    it 'is valid with the existing user and the post' do
      expect(Like.new(user: @user, post: @post)).to be_valid
    end

    it 'is not valid without the post' do
      expect(Like.new(user: @user)).to_not be_valid
    end

    it 'is not valid without the user' do
      expect(Like.new(post: @post)).to_not be_valid
    end
  end

  context '#update_post_likes_counter' do
    before :all do
      8.times { Like.create(user: @user, post: @post) }
    end

    it 'keeps track of likes and equals to 8' do
      expect(@post.likes_counter).to eq 8
    end
  end
end
