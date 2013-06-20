class SessionsController < ApplicationController
  layout 'backoffice'

  def new
    @user = User.new
  end

  def create
    email = user_params[:email].to_s
    password = user_params[:password].to_s

    if login(email, password, true)
      redirect_back_or_to admin_root_path, notice: t('login_succesful', scope: 'flashes.sessions_controller')
    else
      @user = User.new email: email
      flash.now[:alert] = t('login_failed', scope: 'flashes.sessions_controller')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to new_session_path, notice: t('logged_out', scope: 'flashes.sessions_controller')
  end

  private

  def user_params
    @user_params ||= params[:user].presence || {}
  end
end