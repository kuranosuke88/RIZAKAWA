Rails.application.routes.draw do
  get 'notices/index'

  get 'sessions/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/mail', to: 'top#mail', as: :mail;
  get 'top/index'
  
  resources :users
  resources :notices
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
