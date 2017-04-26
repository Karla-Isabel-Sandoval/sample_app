Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  #get '/login', to: 'sessions#new', as: :login
  resources :users
end
#using the get above arranges for route to respond to a GET request
# For details on the DSL available within this file, see
#http://guides.rubyonrails.org/routing.htm
