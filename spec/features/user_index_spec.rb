require 'rails_helper'

RSpec.feature 'User Index', type: :feature do
  scenario 'visiting the user index page' do
    User.create(name: 'Noel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    User.create(name: 'Joel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo')

    visit users_path

    expect(page).to have_content('Noel')
    expect(page).to have_content('Joel')

    # To check that images with specific src URLs are present
    expect(page).to have_selector('img[src="https://unsplash.com/photos/F_-0BxGuVvo"]',
                                  count: 2)
  end

  scenario 'visiting the user index page, you see the number of posts each user has written..' do
    user1 = User.create(name: 'Noel')
    User.create(name: 'Joel')
    Post.create(author: user1, title: 'first post')
    Post.create(author: user1, title: 'second post')
    Post.create(author: user1, title: 'third post')

    visit users_path

    expect(page).to have_content('0')
    expect(page).to have_content('0')
  end

  scenario 'clicking on a user redirects to their show page' do
    user = User.create(name: 'Shalini')

    visit users_path

    click_link 'Shalini'

    expect(page).to have_current_path(user_path(user))
  end
end
