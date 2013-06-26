# encoding: utf-8

I18n.default_locale = :en
ADMIN_LOCALE = :en

LANGUAGES_BY_LOCALE = {
  "en" => 'English',
  "es" => 'Castellano',
  "ca" => 'Català'
}

LANGUAGES = LANGUAGES_BY_LOCALE.to_a.map(&:reverse)
LOCALES = LANGUAGES_BY_LOCALE.keys.map(&:to_sym)
LOCALES_STRING = LANGUAGES_BY_LOCALE.keys
TRANSLATABLE_LOCALES = LOCALES - [I18n.default_locale]