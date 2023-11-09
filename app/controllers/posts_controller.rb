class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @comments = Comment.all
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.new
    @posts = Post.all
    @post = Post.find params[:id]
    @user = current_user
    @post_id = @posts.index(@post) + 1
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @current_user = User.find(params[:user_id])
    @post = @current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@current_user.id, @post.id), notice: 'Post was successfully Created'
    else
      flash[:alert] = 'Error creating the post'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    post = Post.find(params[:id])
    authorize! :destroy, post

    post.comments.destroy_all
    post.likes.destroy_all
    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      redirect_to user_post_path(@user, post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
