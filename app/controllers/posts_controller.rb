class PostsController < ApplicationController
  def index
    @user = user.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @posts = Post.all
    @post = Post.find params[:id]
    @post_id = @posts.index(@post) + 1
  end
end
