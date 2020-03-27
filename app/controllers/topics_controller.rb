class TopicsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user_topic,   only: :destroy

  def create
    @topic = current_user.topics.build(topic_params)
    @tag_list = params[:topic][:tag_list].split(',')
    if @topic.save
      if @topic.save_tags(@tag_list)
        flash[:success] = 'スレッドを作成しました!'
        redirect_to root_url
      else
        @tag_list = params[:topic][:tag_list].split(',')
        @topics = Topic.page(params[:page]).per(20)
        flash.now[:danger] = '空白のタグが含まれています'
        render 'static_pages/home'
      end
    else
      @topics = Topic.page(params[:page]).per(20)
      render 'static_pages/home'
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new(topic_id: @topic.id)
    @comment_page = Comment.where(topic_id: @topic.id).includes(:user)
    @comments = @comment_page.page(params[:page]).per(50)
  end

  def destroy
    @topic.destroy
    flash[:success] = 'トピックを削除しました'
    redirect_to root_url
  end

  private

  def topic_params
    params.require(:topic).permit(:title, tag_list: [])
  end
end
