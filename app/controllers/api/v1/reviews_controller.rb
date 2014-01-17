class Api::V1::ReviewsController < ApplicationController
  respond_to :json

  def index
    @reviews = Review.all
    respond_with @reviews
  end

  def create
    review = Review.create(review_params)
    check_for_store
    if @errors.empty? && User.find(review_params[:user_id])
      respond_with review
    else
      render json: {errors: @errors}, status: 500

    end
  end

  private

  def check_for_store
    if @store = Store.find_by(id: params[:store_id]).nil?
      @errors ||= []
      @errors << "nope"
    end
  end

  def review_params
     params.require(:review).permit(:store_id, :user_id, :body, :title, :rating)
  end
end
