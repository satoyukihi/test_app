Rails.application.routes.draw do
  get  '/signup',    to: 'users#new'
  post '/signup',    to: 'users#create'
  get 'static_pages/home'
  
  resources :users, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 root 'static_pages#home'
end
