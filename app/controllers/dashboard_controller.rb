class DashboardController < ApplicationController
  def index
    if current_user
      @review = Review.new
      @reviews = Review.most_recent(6)
      @store = Store.new
      @store_names = Store.all.collect {|n| n.name}

      @search_results = Search.by(params[:query])
    else
      redirect_to welcome_path
    end
  end
end
