# encoding: utf-8

require 'csv'

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

  def export
    locale = params[:locale].try(:to_sym)
    unless TRANSLATABLE_LOCALES.include?(locale)
      flash[:alert] = "The language you are trying to translate to is not correct"
      redirect_to admin_translations_url
    end

    all = params[:all] == 'true'
    translations = Interpret::Translation.where(:locale => I18n.default_locale.to_s)

    xls_file = CSV.generate(col_sep: "\t") do |csv|
      csv << ['Key', LANGUAGES_BY_LOCALE[I18n.default_locale.to_s], locale]
      translations.each do |translation|
        foreign_value = Interpret::Translation.where(:key => translation.key, :locale => locale).first.try(:value) || ""
        if all || foreign_value.blank?
          csv << [translation.key, translation.value, foreign_value]
        end
      end
    end

    respond_to do |format|
      format.xls do
        send_data xls_file.encode(Encoding::ISO_8859_1, :undef => :replace),
          :type => 'xls; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=translations_#{locale}.xls"
      end
    end
  end

  def import
    if params.include?(:import) && file = params[:import][:file]
      file = params[:import][:file]
      locale = params[:import][:locale]

      keys = 0

      Interpret::Translation.transaction do
        xls = Roo::Excel.new(file.path, false, :ignore)
        (xls.first_row+1..xls.last_row).each do |i|
          key = xls.cell(i, 1)
          in_foreign_language = xls.cell(i, 3)

          translation = Interpret::Translation.find_or_create_by_locale_and_key(locale, key)
          if in_foreign_language.present? && translation.value != in_foreign_language
            translation.update_attribute(:value, in_foreign_language)
            keys += 1
          end
        end
      end

      redirect_to admin_translations_url, :notice => "Translations succesfully imported for #{keys} keys"
    else
      redirect_to admin_translations_url, :alert => "Attach a file, please"
    end
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