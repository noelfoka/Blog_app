class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    @comments = Comment.all
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.new
    @post = Post.find params[:id]
    @posts = Post.all
    @user = current_user
    @post_id = @posts.index(@post) + 1
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post successfully created.'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Error creating the post.'
      render :new
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post successfully deleted.'
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
