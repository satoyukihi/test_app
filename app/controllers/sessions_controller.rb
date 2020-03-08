class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'ログインしました'
      redirect_to root_path
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      render 'sessions/new'
    end
  end

  def destroy
    log_out
    flash[:info] = 'ログアウトしました'
    redirect_to root_url
  end
end
