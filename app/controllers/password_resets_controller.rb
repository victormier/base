class PasswordResetsController < ApplicationController
  layout 'backoffice'

  skip_before_filter :require_login

  # Create a reset password request
  def create
    @user = User.find_by_email(params[:email])

    if @user
      @user.deliver_reset_password_instructions!
      flash[:notice] = t('instructions_sent', :scope => 'flashes.password_resets_controller')
      redirect_to login_path
    else
      flash[:alert] = t('user_not_found', :scope => 'flashes.password_resets_controller')
      render 'new'
    end
  end

  # This is the reset password form.
  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  # This action fires when the user has sent the reset password form.
  def update
    if params[:user]
      @token = params[:user][:token]
      @user = User.load_from_reset_password_token(@token)
      not_authenticated and return unless @user
      auto_login(@user)

      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.change_password!(params[:user][:password])
        redirect_to admin_root_path
      else
        flash[:alert] = t('password_not_set', :scope => 'flashes.password_resets_controller')
        render :action => "edit"
      end
    else
      flash[:alert] = t('password_not_set', :scope => 'flashes.password_resets_controller')
      render :action => "edit"
    end
  end
end
