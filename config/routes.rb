Rails.application.routes.draw do

  

  get  '/signup',    to: 'users#new'
  post '/signup',    to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:new, :create]
  resources :topics, only: [:create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

 root 'static_pages#home'
 
end
