Rails.application.routes.draw do
  get 'microposts/new'
  get 'microposts/edit'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'pages#index'
  get '/signup', to: 'users#new' 
  get'/login', to: 'sessions#new'
  post '/login',to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
