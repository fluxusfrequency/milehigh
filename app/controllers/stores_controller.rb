class StoresController < ApplicationController

  def show
    @store = Leafly::Store.find(params[:id])
  end

end
