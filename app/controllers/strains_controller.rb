class StrainsController < ApplicationController
  respond_to :html, :json

  def show
    @strain = MenuStrain.find_by_slug(params[:slug])
    @stores = Store.find_by_strain(@strain)
  end

  def strain_stores
    @strain = MenuStrain.find_by_slug(params[:query])
    @stores = Store.find_by_strain(@strain)
    render :json => @stores.take(9)
  end

end
