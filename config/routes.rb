Rails.application.routes.draw do
  resources :lists
  get 'sessions/new'
  resources :homes
  resources :users, except: :show
  get "/users/login", to: 'users#login'
  get "/users/logout", to: 'users#logout'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  get 'auth/facebook/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')


  root to: "homes#index"
end
