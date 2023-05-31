class Api::V1::LotsController < ActionController::API
  def show
    lot = Lot.find(params[:id])
    render status: 200, json: lot
  end
  
end