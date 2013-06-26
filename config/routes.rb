Base::Application.routes.draw do
  mount Interpret::Engine => "/admin/interpret"

  # Backoffice
  namespace :admin do
    resources :users, only: [:index, :new, :create, :destroy]
    resources :translations, :only => [:index, :create] do
      get :other_langs, :on => :member
      get :missing, :on => :collection
      get :tools, :on => :collection
      get :export, :on => :collection
      post :import, :on => :collection
    end

    root to: 'users#index'
  end

  scope ":i18n_locale" do
    localized(LOCALES_STRING) do
      resources :sessions, only: [:new, :create, :destroy]
      resources :password_resets, only: [:new, :create, :edit, :update]
    end

    # Sessions
    get 'logout' => 'sessions#destroy', as: 'logout'
    get 'login' => 'sessions#new', as: 'login'

    root to: 'static#index'
  end

  match '/' => 'static#index'
end
