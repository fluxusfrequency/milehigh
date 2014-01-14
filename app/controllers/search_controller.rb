class SearchController < ApplicationController
  respond_to :json

  def new
    @results = Search.by(params[:query])
  end

  def index
    @result = Search.by(params["queryData"])
    response = @result.collect{ |store| [store.name, store.slug] }
    render :json => response
  end

end
