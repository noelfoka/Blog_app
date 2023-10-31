require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get posts_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get posts_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get posts_path
      expect(response.body).to include('Here is a list of all posts')
    end
  end

  describe 'GET #show' do
    let(:post) { Post.create(id: 1, title: 'Sample Post', text: 'This is the content of the post') }

    it 'returns a successful response' do
      get post_path(post.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get post_path(post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get post_path(post)
      expect(response.body).to include('Post Details')
    end
  end
end
