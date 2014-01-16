Milehigh::Application.routes.draw do

  root 'dashboard#index'

  get 'welcome' => 'welcome#index'

  get 'auth/:provider/callback' => 'sessions#create', only: %i(get post)
  get 'auth/failure', to: redirect('/')
  get 'signout' => 'sessions#destroy', only: %i(get delete), as: :signout
  get '/search' => 'search#new'
  get 'my-profile' => 'users#show', as: "user_profile"
  post '/search' => 'search#index', as: "strain"
  post '/' => 'reviews#new'
  get '/strain/:slug' => 'strains#show', as: "strain_show"
  get '/stores/:slug' => 'stores#show', as: "store"
  resources :stores, only: [:index]
  resources :reviews

end

