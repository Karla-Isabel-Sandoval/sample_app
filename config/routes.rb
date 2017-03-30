Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  root 'application#hello'
end

#using the get above arranges for route to respond to a GET request

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
