class PostsController < ApplicationController
  def index
    @comments = Comment.all
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    set_current_user
    @user = @current_user
    @posts = @user.posts.order(created_at: :desc)
    post_id = params[:id]
    @post = @posts.find(post_id)
    @post_id = @posts.find_index(@post) + 1
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    set_current_user
    @post = @current_user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(@current_user.id, @post.id), notice: 'Post was successfully Created'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
