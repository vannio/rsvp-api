Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'join' }
  root to: "home#index"
  resources :addresses
  resources :users do
    resources :rsvps
  end
  resources :events do
    resources :venues
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
