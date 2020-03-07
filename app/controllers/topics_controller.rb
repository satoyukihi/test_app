class TopicsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user,   only: :destroy

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = 'スレッドを作成しました!'
      redirect_to root_url
    else
      @topics = Topic.all
      render 'static_pages/home'
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new(topic_id: @topic.id)
    @comments = Comment.where(topic_id: @topic.id)
  end

  def destroy
    @topic.destroy
    flash[:success] = 'トピックを削除しました'
    redirect_to root_url
  end

  private

  def topic_params
    params.require(:topic).permit(:title)
  end
end
