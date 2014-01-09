class SearchController < ApplicationController

  def new
    store = Leafly::Store.find_by(name: params[:query])
    if store
      redirect_to "/leafly/stores/#{store.id}"
    else
      redirect_to :back
    end
  end

end
