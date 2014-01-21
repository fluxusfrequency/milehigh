class StoresController < ApplicationController

  def show
    @store = Store.find_by(slug: params[:slug])
    @reviews = Review.where(:store_id => @store.id).limit(5)
    @strains = MenuStrain.by_store(@store)
  end

  def index
    @search = Store.search do
      fulltext params[:search]
    end
    @stores = @search.results
  end


end
