class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    email = user_params[:email].to_s
    password = user_params[:password].to_s

    if login(email, password, true)
      redirect_back_or_to root_path, notice: 'Login successful'
    else
      @user = User.new email: email
      flash.now[:alert] = "Login failed"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to new_session_path, :notice => 'Logged out!'
  end

  private

  def user_params
    @user_params ||= params[:user].presence || {}
  end
end