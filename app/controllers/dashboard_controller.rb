class DashboardController < ApplicationController
  def index
    if current_user
      @review = Review.new
      @reviews = Review.most_recent(3)
      @store_names = Leafly::Store.all.collect {|n| n.name}
    else
      redirect_to welcome_path
    end
  end
end
