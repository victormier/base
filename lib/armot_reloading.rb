module ArmotReloading
  def reload_armot!
    I18n.backend.reload!
    Rails.cache.clear
  end
end
