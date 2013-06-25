class Admin::TranslationsController < Admin::ApplicationController
  def index
    @translations = Interpret::Translation.order('translations.key').paginate(:page => params[:page], :per_page => 20)
  end

  def other_langs
    if @translation = Interpret::Translation.find(params[:id])
      @translations = Interpret::Translation.where('translations.key = ? AND translations.locale != ?', @translation.key, @translation.locale)
    end
    render :layout => false
  end
end