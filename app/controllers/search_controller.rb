class SearchController < ApplicationController
  respond_to :json

  def new
    @results = Search.by(params[:query])
  end

  def index
    @result = Search.by(params["queryData"])
    render :json => @result

  end

end
