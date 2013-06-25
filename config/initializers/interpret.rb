Interpret.configure do |config|
  config.registered_envs << :development
  config.parent_controller = "admin/interpret_controller"
  config.soft = true
  config.sweeper = "interpret_observer"
end