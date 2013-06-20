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
      flash[:notice] = t('user_created', scope: 'flashes.users_controller')
      redirect_to admin_users_path
    else
      flash[:error] = t('creation_error', scope: 'flashes.users_controller')
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])

    if User.count <= 1 || @user == current_user
      flash[:error] = t('deletion_error', scope: 'flashes.users_controller')
      redirect_to :back
    else
      @user.destroy
      flash[:notice] = t('user_deleted', scope: 'flashes.users_controller')
      redirect_to admin_users_path
    end
  end
end