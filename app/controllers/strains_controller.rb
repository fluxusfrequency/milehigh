class StrainsController < ApplicationController

  def show
    @strain = MenuStrain.find_by_slug(params[:slug])
    @stores = Store.find_by_strain(@strain)
  end

end
