class Api::V1::LotsController < ActionController::API
  def show
    begin
      lot = Lot.find(params[:id])
      render status: 200, json: lot.as_json(except: [:created_at, :updated_at])
    rescue
      render status: 404
    end
  end
  
  def index
    lots = Lot.all.order(:code)
    render status: 200, json: lots.as_json(except: [:created_at, :updated_at])
  end

end