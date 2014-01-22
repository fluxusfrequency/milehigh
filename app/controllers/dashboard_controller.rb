class DashboardController < ApplicationController
  def index
    if current_user
      @review = Review.new
      @friend_reviews = current_user.friend_reviews.take(3)
      @reviews = Review.most_recent(3, current_user)
      @store = Store.new
      @store_names = Store.all.collect {|n| n.name}
      if params[:query]
        @search_results = Search.by(params[:query])
      end
    else
      redirect_to welcome_path
    end
  end
end
