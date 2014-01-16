class Api::V1::ReviewsController < ApplicationController
  respond_to :json

  def index
    @reviews = Review.all
    respond_with @reviews
  end
end