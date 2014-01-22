class ReviewsController < ApplicationController
  respond_to :json, :html

  def new
    @store = Store.find_by(name: params[:store_name])
    redirect_to store_path(@store)
  end

  def create
    store = Store.find_by(name: params[:review][:store_name])
    if store
      review = store.reviews.create(review_params)
      review.update_attributes(rating: params[:commit], user_id: current_user.id)
      if review.valid?
        flash[:notice] = "Your review of #{store.name} was successfully created!"
      else
        flash[:error] = "Errors prevented your review from being created: #{review.errors.full_messages}"
      end
    end

    redirect_to store_path(store.slug)
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end

end
