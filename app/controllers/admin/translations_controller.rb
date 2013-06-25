class Admin::TranslationsController < Admin::ApplicationController
  def index
    @translations = Interpret::Translation.scoped
    @search_params = Hash["key" => "", "value" => "", "language" => "All"]

    if params[:search].present?
      @search_params = params[:search]
      t = Interpret::Translation.arel_table
      @translations = @translations.where(t[:key].
        matches("%#{params[:search][:key]}%").
        and(t[:value].matches("%#{params[:search][:value]}%")))
      if LOCALES.include?(params[:search][:language].to_sym)
        @translations = @translations.where(t[:locale].eq("#{params[:search][:language]}"))
      end
    end

    @translations = @translations.order('translations.key').paginate(:page => params[:page], :per_page => 20)
  end

  def other_langs
    if @translation = Interpret::Translation.find(params[:id])
      @translations = Interpret::Translation.where('translations.key = ? AND translations.locale != ?', @translation.key, @translation.locale)
    end
    render :layout => false
  end
end