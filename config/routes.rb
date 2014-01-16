Milehigh::Application.routes.draw do

  root 'dashboard#index'

  get 'welcome' => 'welcome#index'

  get 'auth/:provider/callback' => 'sessions#create', only: %i(get post)
  get 'auth/failure', to: redirect('/')
  get 'signout' => 'sessions#destroy', only: %i(get delete), as: :signout
  get '/search' => 'search#new'
  get 'my-profile' => 'users#show', as: "user_profile"
  post '/search' => 'search#index'
  post '/' => 'reviews#new'
  resources :stores, only: [:show]
  resources :reviews
end

