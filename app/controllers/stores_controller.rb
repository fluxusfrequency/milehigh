class StoresController < ApplicationController

  def show
    @store = Store.find(params[:id])
    @strains = MenuStrain.by_store(@store)
  end

  def index 
    @search = Store.search do 
      fulltext params[:search]
    end
    @stores = @search.results
  end


end
