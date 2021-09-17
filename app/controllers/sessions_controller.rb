class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました'
      redirect_to user_path(user)
    else
      flash.now[:danger] = '入力されたメールアドレスまたはパスワードは正しくありません。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to top_path
  end
end
