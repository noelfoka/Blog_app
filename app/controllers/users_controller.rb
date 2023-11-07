class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts
    @recent_posts = @user_posts.limit(3)
  end
end
