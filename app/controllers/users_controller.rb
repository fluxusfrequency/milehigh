class UsersController < ApplicationController

  def show
    @thumbs_up_review_count = current_user.reviews.where(rating: "Thumbs Up").count
    @thumbs_down_review_count = current_user.reviews.where(rating: "Thumbs Down").count
  end

end
