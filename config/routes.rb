Milehigh::Application.routes.draw do

  root 'dashboard#index'

  get 'welcome' => 'welcome#index'

  get 'auth/:provider/callback' => 'sessions#create', only: %i(get post)
  get 'auth/failure', to: redirect('/')
  get 'signout' => 'sessions#destroy', only: %i(get delete), as: :signout
  resources :stores, only: [:show, :index]
  resources :reviews
end

