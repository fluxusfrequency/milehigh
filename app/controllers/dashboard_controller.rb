class DashboardController < ApplicationController
  def index
    @review = Review.new
    @reviews = Review.most_recent(3)
    @store_names = Leafly::Store.all.collect {|n| n.name}
  end
end
