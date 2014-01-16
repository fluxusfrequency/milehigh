class Api::V1::StoresController < ApplicationController
  respond_to :json

  def new
    respond_with Store.new
  end

  def index
    @stores = Store.all
    respond_with @stores
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      respond_with @store
    else
      render :json => @store.errors, status: 400
    end
  end

  def show
    @store = Store.find_by(slug: params[:slug])
    respond_with @store
  end

  def update
    @store = Store.find_by(slug: params[:slug])
    @store.update_attributes(store_params)
    if @store.valid?
      render :json => @store
    else
      render :json => @store.errors, status: 400
    end
  end

  def destroy
    @store = Store.find_by(slug: params[:slug])
    if @store.destroy
      render :json => "Success!", status: 200
    else
      render :json => "Error", status: 400
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :slug, :address, :city, :state, :zipcode, :hours, :website, :phone_number, :menu)
  end

end