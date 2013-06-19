Base::Application.routes.draw do
  # Backoffice
  namespace :admin do
    resources :users, only: [:new, :create]
  end

  root :to => 'static#index'
end
