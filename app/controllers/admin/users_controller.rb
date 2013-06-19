class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "User succesfully created"
      render 'new'
    else
      flash[:error] = "There was an error"
      redirect_to root_path
    end
  end
end