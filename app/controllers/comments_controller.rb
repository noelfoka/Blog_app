class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @user = @current_user
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(author: @user))

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end
  # destroy the comment
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.decrement!(:comments_counter)
    @comment.destroy
    redirect_to user_post_path(author_id: @post.author_id, id: @post.id), notice: 'Comment successfully deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
