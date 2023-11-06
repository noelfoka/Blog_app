require 'rails_helper'

RSpec.feature 'Post Index', type: :feature do
  let(:user) { User.create(name: 'Tom', bio: 'He is a good programmer') }
  let!(:post) { Post.create(author: user, title: "first post's title", text: 'first text') }
  let!(:comment1) { Comment.create(author: user, post:, text: 'hello Tom') }
  let!(:comment2) { Comment.create(author: user, post:, text: 'Thank You Tom') }
  let!(:comment3) { Comment.create(author: user, post:, text: 'Good afternoon Tom') }
  let!(:like1) { Like.create(user:, post:) }

  before do
    user.update(photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png')
  end

  scenario "see user's profile picture, username, number of posts and interactions" do
    visit user_posts_path(user)

    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/leaf-blue.png"]')
    expect(page).to have_content('Tom')
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Comments: 3')
    expect(page).to have_content('Likes: 1')
  end
end

RSpec.feature 'Post Index', type: :feature do
  let(:user) { User.create(name: 'Tom', bio: 'He is a good programmer') }
  let!(:post) { Post.create(author: user, title: "first post's title", text: 'first text') }
  let!(:comment1) { Comment.create(author: user, post:, text: 'hello Tom') }
  let!(:comment2) { Comment.create(author: user, post:, text: 'Thank You Tom') }
  let!(:comment3) { Comment.create(author: user, post:, text: 'Good afternoon Tom') }
  let!(:like1) { Like.create(user:, post:) }

  before do
    user.update(photo: 'https://www.kasandbox.org/programming-images/avatars/leaf-blue.png')
  end

  scenario "see some of the post's title, body and first comments" do
    visit user_posts_path(user)
    expect(page).to have_content('first post\'s title')
    expect(page).to have_content('hello Tom')
    expect(page).to have_content("first post's title")
  end

  scenario 'see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(user)
    expect(page).to have_selector('.pagination')
  end

  scenario "clicking on a post, it redirects me to that post's show page" do
    visit user_posts_path(user)
    click_link 'Post #1'
    expect(page).to have_current_path(user_post_path(user, post))
  end
end
