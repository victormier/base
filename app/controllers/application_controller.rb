class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_locale
  before_filter :set_locale

  def check_locale
    if request.env['PATH_INFO'] == '/'
      redirect_to "/#{I18n.default_locale.to_s}"
    elsif !LANGUAGES.map{|x| x.last}.include?(params[:i18n_locale])
      raise ActionController::RoutingError, "invalid route"
      return
    end
  end

  def set_locale
    I18n.locale = params[:i18n_locale].to_sym
  end

  def default_url_options(options = {})
    options.merge({i18n_locale: I18n.locale})
  end
end
