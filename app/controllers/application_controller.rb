class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'ログインしてください'
    store_location
    redirect_to login_url
  end
end
