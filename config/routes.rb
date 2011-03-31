Rails.application.routes.draw do
  namespace :authengine do
    resources :accounts
    resources :actions
    resources :useractions
    resources :action_roles do
      put 'update_all', :on => :collection
    end

    resources :sessions
    resources :roles
    resources :users do
      resource :account
      resources :roles

      member do
        put 'enable'
        put 'disable'
        put 'update_self'

        match 'signup'
      end

      collection do
        get 'edit_self'

        match ':activation_code/activate' => 'users#activate', :via => :post
      end
    end

  end
  match '/activate(/:activation_code)' => "accounts#show", :as => :activate, :via => :get # actually activation_code is always required, but handling it as optional permits its absence to be communicated to the user as a flash message
  match '/login' => "sessions#new"
  match '/logout' => "sessions#destroy"

  root :to => "authengine/sessions#new"
end
