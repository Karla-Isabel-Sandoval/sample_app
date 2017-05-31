Rails.application.routes.draw do
  #root 'static_pages#home'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  # get '/account_activations', to: 'sessions#new'
  get 'password_resets/edit/:id', to: 'account_activations#edit'
  # just added line 10
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
end
#using the get above arranges for route to respond to a GET request
# For details on the DSL available within this file, see
#http://guides.rubyonrails.org/routing.htm
