Rails.application.routes.draw do
  resources :posts
  devise_for :users, :path => 'accounts', controllers: { registrations: "registrations", :omniauth_callbacks => "callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :feed
  resources :friendships
  resources :comments
  resources :likes
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
