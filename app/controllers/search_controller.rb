class SearchController < ApplicationController
  respond_to :json

  def new
  end

  def create
    # @results = Search.by(params[:query])
  end

  def show
    @stores = Search.by(params[:query])
  end

  def index
    @results = Search.by(params["query"])

    render :json => @results.take(9)
  end

end
