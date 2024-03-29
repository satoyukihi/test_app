class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user_comment,   only: :destroy

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = current_user.comments.build(comment_params)
    @comment.topic = @topic
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_to @comment.topic
    else
      @comment_page = Comment.where(topic_id: @topic.id)
      @comments = @comment_page.page(params[:page]).per(50)
      render template: 'topics/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
      @comment.destroy
      flash[:success] = 'コメントを削除しました'
    redirect_to @comment.topic
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
