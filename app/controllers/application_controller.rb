class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしてください'
    store_location
    redirect_to login_url
  end

  def correct_user_topic
    @topic = current_user.topics.find_by(id: params[:id])
    redirect_to root_url if @topic.nil?
  end
  
  def correct_user_comment
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
