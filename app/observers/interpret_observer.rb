class InterpretObserver < Interpret::ExpirationObserver
  def expire_cache(key)
    I18n.backend.reload!
    Rails.cache.clear
  end

  def expire_cache_all
    I18n.backend.reload!
    Rails.cache.clear
  end
end