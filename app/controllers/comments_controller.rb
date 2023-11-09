class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @user = @current_user
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user: @user))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])

    if @comment.user == @user
      @comment.destroy
      flash[:notice] = 'Comment successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end
    redirect_to user_post_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
