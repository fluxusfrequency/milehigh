class ReviewsController < ApplicationController
  respond_to :json, :html

  def new
    @store = Store.find_by(name: params[:store_name])
    redirect_to store_path(@store)
  end

  def create
    respond_to do |format|
      format.html do
        store = Store.find(params[:review][:store_id])
        if store
          review = store.reviews.create(review_params)
          review.update_attributes(rating: params[:commit])
          if review.valid?
            flash[:notice] = "Your review of #{store.name} was successfully created!"
          else
            flash[:error] = "Errors prevented your review from being created: #{review.errors.full_messages}"
          end
        end

        redirect_to store_path(store)
      end
      # format.json do
      #   found_store = Store.find_by(name: params[:review][:store])
      #   if found_store
      #     review = found_store.reviews.build(
      #       title: params[:review][:title],
      #       body: params[:review][:body],
      #       rating: params[:review][:rating],
      #       store: found_store)
      #     review.save
      #   end
      #   respond_with review
      # end
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end

end
