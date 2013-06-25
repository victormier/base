class Admin::InterpretController < Admin::ApplicationController
  def default_url_options(options = {})
    options.merge({:locale => I18n.locale})
  end
end