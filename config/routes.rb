Rails.application.routes.draw do
  
  get 'lessons/weeklyschedule'
  post 'lessons/create', to: 'lessons#create'
  post 'reservationusers/useredit', to: 'reservationusers#useredit'
  get 'reservationusers/useredit', to: 'reservationusers#useredit'
  post 'reservationusers/userupdate', to: 'reservationusers#userupdate'
  post 'reservationusers/reservation_change_user', to: 'reservationusers#reservation_change_user'
  post 'reservationusers/reservationnewuser', to: 'reservationusers#reservationnewuser'
  post 'reservationusers/reservationnewusercreate', to: 'reservationusers#reservationnewusercreate'
  get 'sessions/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'reservations/reservations_log'
      get 'edit_basic_info'
      patch 'update_basic_info'
    end
  end
  
  resources :lessons do
   member do
     get 'lesson_detail'
     patch 'lesson_detail'
     get 'lesson_discontinuation_fix'
     patch 'lesson_discontinuation_fix'
   end
  end
  resources :notices
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :reservations
end
