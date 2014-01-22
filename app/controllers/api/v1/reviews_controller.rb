class Api::V1::ReviewsController < ApplicationController
  respond_to :json

  def index
    @reviews = Review.all
    respond_with @reviews
  end

  def create
    @errors ||= []
    @review = Review.new(review_params)
    check_for_store
    if @errors.empty?
      @review.save!
      respond_with @review
    else
      render :json => @errors, status: 500
    end
    @errors = []
  end

  def show
    @review = Review.find_by(id: params[:id])
    respond_with @review
  end

  def for_store
    store = Store.find_by(slug: params[:slug])
    response = [{"slug" => store.slug}] + store.reviews.to_a
    render :json => response
  end

  private

  def check_for_store
    if Store.find_by(id: @review.store_id).nil?
      @errors << "not a valid store"
    end
  end

  def review_params
     params.require(:review).permit(:store_id, :user_id, :body, :title, :rating)
  end
end
