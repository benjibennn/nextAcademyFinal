Rails.application.routes.draw do
  resources :lists
  get 'sessions/new'
  resources :homes, except: :show
  resources :users, except: :show
  get "/users/login", to: 'users#login'
  get "/users/logout", to: 'users#logout'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  get "/auth/google_oauth2/callback" => "sessions#create_from_omniauth"
  get '/redirect', to: 'sessions#redirect', as: 'redirect'
  get '/callback', to: 'sessions#callback', as: 'callback'
    get 'homes/quote', to: 'homes#quote', as: 'quote'

  root to: "homes#index"
end
