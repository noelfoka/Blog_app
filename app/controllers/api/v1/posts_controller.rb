=begin
class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
    render json: @posts
  end
end
