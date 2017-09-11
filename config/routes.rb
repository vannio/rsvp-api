Rails.application.routes.draw do
  concern :api_base do
    post 'authenticate', to: 'authentication#authenticate'
    root to: 'home#index'
    resources :users do
      resources :rsvps
      resources :addresses
    end
    resources :events do
      resources :rsvps
      resources :venues do
        resources :addresses
      end
    end
  end

  namespace :api do
    post 'graphql', to: 'graphql#create'
    namespace :v1 do
      concerns :api_base
    end
  end
end
