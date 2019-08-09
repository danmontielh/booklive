Rails.application.routes.draw do
  resources :letters
  get 'user/show_letters', to: 'letters#index', as: 'show_letters'
  resources :posts
  get 'feed_posts', to: 'posts#index', as: 'feed_posts'
  devise_for :users, :path => 'accounts', controllers: { registrations: "registrations", :omniauth_callbacks => "callbacks" }
  resources :users
  patch 'update_avatar/:id', to: 'users#update_avatar', as: 'update_avatar'
  resources :friendships
  delete 'destroy_friendship/:id', to: 'friendships#destroy_friendship', as: 'destroy_friendship'
  resources :comments
  resources :likes
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

end
