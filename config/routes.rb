Rails.application.routes.draw do
  concern :api_base do
    post 'authenticate', to: 'authentication#authenticate'
    root to: "home#index"
    resources :addresses
    resources :rsvps, only: [:index]
    resources :users do
      resources :rsvps, except: [:index]
    end
    resources :events do
      resources :venues
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
