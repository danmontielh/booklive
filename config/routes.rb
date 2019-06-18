Rails.application.routes.draw do
  devise_for :users, :path => 'accounts', controllers: { registrations: "registrations", :omniauth_callbacks => "callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :feed
  root 'home#index'

  
   
end
