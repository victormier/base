require 'i18n/backend/active_record'

I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)
I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Fallbacks)

if Rails.env.development? || Rails.env.test?
  # Chain it with Simple backend in development, so we can add new
  # translations and edit them and the changes take place in live
  Interpret.backend = I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n.backend)
else
  # in production and test envs, only activerecord backend
  Interpret.backend = I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n.backend)
end

I18n.backend = Interpret.backend