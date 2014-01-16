class StoresController < ApplicationController

  def show
    @store = Store.find(params[:id])
    @menu = JSON.parse(@store.menu)
  end

end
