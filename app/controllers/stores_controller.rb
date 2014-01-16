class StoresController < ApplicationController

  def show
    @store = Store.find(params[:id])
    @menu = JSON.parse(@store.menu)
  end

  def index 
    @search = Store.search do 
      fulltext params[:search]
    end
    @stores = @search.results
  end


end
