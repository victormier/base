class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login

  layout 'backoffice'

  protected

  def not_authenticated
    redirect_to login_path, alert: t('login_first', scope: 'flashes.admin_application_controller')
  end
end