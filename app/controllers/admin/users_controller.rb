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

  def destroy
    @user = User.find(params[:id])
    
    @user.destroy
    flash[:notice] = "User succesfully deleted"
    redirect_to admin_users_path
  end
end