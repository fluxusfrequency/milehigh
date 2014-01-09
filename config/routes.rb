Milehigh::Application.routes.draw do

mount Leafly::Engine, at: "leafly"

  root 'welcome#index'

  get 'home' => 'dashboard#index'

  get 'auth/:provider/callback' => 'sessions#create', only: %i(get post)
  get 'auth/failure', to: redirect('/')
  get 'signout' => 'sessions#destroy', only: %i(get delete), as: :signout

end

