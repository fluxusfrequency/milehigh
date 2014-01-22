class Api::V1::StoresController < ApplicationController
  respond_to :json

  def index
    @stores = Store.all
    respond_with @stores
  end

  def show
    @store = Store.find_by(slug: params[:slug])
    respond_with @store
  end

end
