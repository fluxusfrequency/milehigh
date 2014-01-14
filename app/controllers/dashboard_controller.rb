class DashboardController < ApplicationController
  def index
    if current_user
      @review = Review.new
      @reviews = Review.most_recent(3)

      @store_names = Leafly::Store.all.collect {|n| n.name}

      @search_results = Search.by(params[:query])

      # @user = current_user
      @thumbs_up_review_count = current_user.reviews.where(rating: "Thumbs Up").count
      @thumbs_down_review_count = current_user.reviews.where(rating: "Thumbs Down").count
    else
      redirect_to welcome_path
    end
  end
end
