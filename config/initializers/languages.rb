# encoding: utf-8

I18n.default_locale = :en

LANGUAGES_BY_LOCALE = {
  "en" => 'English',
  "es" => 'Castellano',
  "ca" => 'Català'
}

LANGUAGES = LANGUAGES_BY_LOCALE.to_a.map(&:reverse)
LOCALES = LANGUAGES_BY_LOCALE.keys.map(&:to_sym)
TRANSLATABLE_LOCALES = LOCALES - [I18n.default_locale]