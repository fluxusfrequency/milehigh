class UsersController < ApplicationController

  def show
    @thumbs_up_review_count = current_user.reviews.where(rating: "Thumbs Up").count
    @thumbs_down_review_count = current_user.reviews.where(rating: "Thumbs Down").count
    @large_avatar = current_user.find_large_avatar
    @friend_count = current_user.friends_on_milehigh.count
    @reviews = current_user.reviews
  end

end
