require 'swagger_helper'

RSpec.describe 'api/blog_app', type: :request do
    let!(:user) { User.create(name: 'test_user', bio: 'this is bio', photo: 'user1.jpg') }
  let!(:user_comment) { User.create(name: 'John', bio: 'this is bio', photo: 'John.jpg') }
  let!(:post1) { Post.create(author: user, title: 'Post 1', text: 'this is body of a post') }
  let!(:post2) { Post.create(author: user, title: 'Post 2', text: 'Body 2') }
  let!(:comment1) { Comment.create(post: post1, text: 'Comment 1', user: user_comment) }
  let!(:comment2) { Comment.create(post: post1, text: 'Comment 2', user: user_comment) }
  let!(:comment3) { Comment.create(post: post1, text: 'Comment 3', user: user_comment) }
  let!(:comment4) { Comment.create(post: post1, text: 'Comment 4', user: user_comment) }
  let!(:comment5) { Comment.create(post: post1, text: 'Comment 5', user: user_comment) }
  let!(:comment6) { Comment.create(post: post1, text: 'Comment 6', user: user_comment) }

    describe 'API V1 Users' do
        path '/api/v1/users' do
          post 'Creates a user' do
            tags 'Users'
            consumes 'application/json'
            parameter name: :user, in: :body, schema: {
              type: :object,
              properties: {
                name: { type: :string },
                photo: { type: :string },
                bio: { type: :string },
                email: { type: :string },
                password: { type: :string },
                password_confirmation: { type: :string }
              },
              required: ['name', 'email', 'password', 'password_confirmation']
            }
      
            response '201', 'user created' do
              let(:user) { { name: 'John Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }
              run_test!
            end
      
            response '422', 'invalid request' do
              let(:user) { { name: 'John Doe', email: 'john@example.com' } }
              run_test!
            end
          end
      
        end
      end

      path '/api/v1/users/{user_id}/posts' do
        get 'Retrieves a list of posts for a user' do
          tags 'Posts'
          produces 'application/json'
          parameter name: :user_id, in: :path, type: :string, description: 'ID of the user'
    
          response '200', 'list of posts found' do
            schema type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       title: { type: :string },
                       text: { type: :string }
                     },
                     required: ['id', 'title', 'text']
                   }
    
            let(:user_id) { user.id }
            run_test!
          end
    
          response '404', 'user not found' do
            let(:user_id) { 'invalid' }
            run_test!
          end
        end
    
        post 'Creates a post for a user' do
          tags 'Posts'
          consumes 'application/json'
          parameter name: :user_id, in: :path, type: :string, description: 'ID of the user'
          parameter name: :post, in: :body, schema: {
            type: :object,
            properties: {
              title: { type: :string },
              text: { type: :string }
            },
            required: ['title', 'text']
          }
    
          response '201', 'post created' do
            let(:user_id) { user.id }
            let(:post) { { title: 'New Post', text: 'This is the content of the new post.' } }
            run_test!
          end
    
          response '422', 'invalid request' do
            let(:user_id) { user.id }
            let(:post) { { title: 'New Post' } }
            run_test!
          end
        end
      end
    end

    describe 'API V1 Comments' do
      
        path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
          get 'Retrieves a list of comments for a post' do
            tags 'Comments'
            produces 'application/json'
            parameter name: :user_id, in: :path, type: :string, description: 'ID of the user'
            parameter name: :post_id, in: :path, type: :string, description: 'ID of the post'
      
            response '200', 'list of comments found' do
              schema type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         text: { type: :string }
                       },
                       required: ['id', 'text']
                     }
      
              let(:user_id) { user.id }
              let(:post_id) { post.id }
              run_test!
            end
      
            response '404', 'user or post not found' do
              let(:user_id) { 'invalid' }
              let(:post_id) { 'invalid' }
              run_test!
            end
          end
      
          post 'Creates a comment for a post' do
            tags 'Comments'
            consumes 'application/json'
            parameter name: :user_id, in: :path, type: :string, description: 'ID of the user'
            parameter name: :post_id, in: :path, type: :string, description: 'ID of the post'
            parameter name: :comment, in: :body, schema: {
              type: :object,
              properties: {
                text: { type: :string }
              },
              required: ['text']
            }
      
            response '201', 'comment created' do
              let(:user_id) { user.id }
              let(:post_id) { post.id }
              let(:comment) { { text: 'New Comment' } }
              run_test!
            end
      
            response '422', 'invalid request' do
              let(:user_id) { user.id }
              let(:post_id) { post.id }
              let(:comment) { { text: '' } }
              run_test!
            end
          end
        end
      end
end

