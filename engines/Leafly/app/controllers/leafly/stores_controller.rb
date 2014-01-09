module Leafly

  class StoresController < ApplicationController
    
    def show
      @stores = Store.all
      @store = Leafly::Store.find_by(id: params[:id])
    end

  end
end
