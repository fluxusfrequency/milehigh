class ReviewsController < ApplicationController
  def create
    store = Leafly::Store.find_by(name: params[:review][:store])
    review = store.reviews.create(review_params)
    review.update_attributes(rating: params[:commit])
    if review.valid?
      flash[:notice] = "Your review of #{store.name} was created."
    else
      flash[:error] = "Errors prevented your review from being created: #{review.errors.full_messages}"
    end
    redirect_to home_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
