class StrainsController < ApplicationController

  def show
    @strain = MenuStrain.find_by(params[:name])
  end


end
