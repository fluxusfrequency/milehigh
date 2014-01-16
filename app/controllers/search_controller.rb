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
    @result = Search.by(params["queryData"])
    render :json => @result
  end

end
