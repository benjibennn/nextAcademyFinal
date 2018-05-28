Rails.application.routes.draw do
  resources :lists
  get 'sessions/new'

  resources :homes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except: :show
  get "/users/login", to: 'users#login'
  get "/users/logout", to: 'users#logout'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'


  root to: "homes#index"
end
