class StrainsController < ApplicationController

  def show
    @strain = MenuStrain.find_by_slug(params[:slug])
  end


end
