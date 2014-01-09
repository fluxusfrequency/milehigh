class ReviewsController < ApplicationController
  def create
    store = Leafly::Store.find_by(name: params[:review][:store])
    if store
      review = store.reviews.create(review_params)
      review.update_attributes(rating: params[:commit])
      if review.valid?
        flash[:notice] = "Your review of #{store.name} was created."
      else
        flash[:error] = "Errors prevented your review from being created: #{review.errors.full_messages}"
      end
    else
      flash[:error] = "Could not find the store you wanted to review. Please try again later."
    end

    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
