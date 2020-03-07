class TopicsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user,   only: :destroy
  
  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = 'スレッドを作成しました!'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def show
  end
  
  def destroy
  end
  
  private

  def topic_params
    params.require(:topic).permit(:title)
  end

  def correct_user
    @topic = current_user.topics.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
  
end
