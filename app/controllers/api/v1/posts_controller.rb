class Api::V1::PostsController < ApplicationController
  def index
    @posts = User.find(params[:user_id]).posts
    render json: @posts
  end

  def show
    @post = @user.posts.find(params[:id])
    render json: @post
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
