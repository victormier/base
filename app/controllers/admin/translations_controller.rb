# encoding: utf-8

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

  def create
    @translation = Interpret::Translation.new(params[:translation])

    if @translation.save
      flash[:notice] = "S'ha creat una nova traducció per a #{@translation.key}"
      redirect_to missing_admin_translations_url
    else
      flash[:alert] = "Hi ha hagut un error al crear la traducció"
      redirect_to missing_admin_translations_url
    end
  end

  def other_langs
    if @translation = Interpret::Translation.find(params[:id])
      @translations = Interpret::Translation.where('translations.key = ? AND translations.locale != ?', @translation.key, @translation.locale)
    end
    render :layout => false
  end

  def missing
    @missing_translations = get_missing_translations
    @translation = Interpret::Translation.new
  end

  private

  def get_missing_translations
    missing_translations = Hash.new []

    Interpret::Translation.all.group_by(&:key).each do |key, translations|
      if base = translations.find{|ta| ta['locale'] == I18n.default_locale.to_s }
        (TRANSLATABLE_LOCALES - translations.map { |t| t.locale.to_sym }).each do |missing_locale|
           missing_translations[missing_locale] = missing_translations[missing_locale] << {:key => key, :base_value => base['value']}
        end
      end
    end
    missing_translations
  end
end