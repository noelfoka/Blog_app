class UsersController < ApplicationController
    def index
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id])
      @recent_posts = @user.three_most_recent_posts
      @posts = Post.all
      @post = Post.find params[:id]
      @post_id = @posts.index(@post) + 1
    end
  end