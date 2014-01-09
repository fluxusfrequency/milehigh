Milehigh::Application.routes.draw do

  root 'dashboard#index'

  get 'auth/:provider/callback' => 'sessions#create', only: %i(get post)
  get 'auth/failure', to: redirect('/')
  get 'signout' => 'sessions#destroy', only: %i(get delete), as: :signout


  # resources :articles, only: [:index, :show]

  # get 'articles' => 'articles#index'
  # get 'articles/new' => 'articles#new'
  # get 'articles/:article' => 'articles#show'
  # get 'articles/edit/:article' => 'articles#edit'
  # post 'articles' => 'articles#create'
  # put 'articles/:article' => 'articles#update'
  # delete 'articles/:article' => 'articles#destroy'

end


# class ArticlesController < ActionController::Base
#   def index
#   end

#   def new
#   end

#   def edit
#   end

#   def show
#   end

#   def create
#     redirect_to articles_path == '/articles'
#   end

#   def update
#     redirect_to article_path(@article) == '/articles/5'
#   end

#   def destroy
#     redirect_to articles_path == '/articles'
#   end

# end
