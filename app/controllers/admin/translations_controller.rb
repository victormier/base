class Admin::TranslationsController < Admin::ApplicationController
  def index
    @translations = Interpret::Translation.order('translations.key').paginate(:page => params[:page], :per_page => 20)
  end
end