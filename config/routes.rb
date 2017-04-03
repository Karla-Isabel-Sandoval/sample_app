Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
  #get 'static_pages/root'
end

#using the get above arranges for route to respond to a GET request

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
