class Api::V1::LotsController < Api::V1::ApiController
  def show
    lot = Lot.where(status: :approved).find(params[:id])
    render status: 200, json: lot.as_json(except: [:created_at, :updated_at])
  end
  
  def index
    lots = Lot.where(status: :approved).order(:code)
    render status: 200, json: lots.as_json(except: [:created_at, :updated_at])
  end

  def create
    lot_params = params.require(:lot).permit(:code, :start_date, :end_date, :minimum_bid, :minimum_bid_increment, :creator_id)

    lot = Lot.new(lot_params)
    
    if lot.save
      render status: 201, json: lot.as_json(except: [:created_at, :updated_at])
    else
      render status: 412, json: { errors: lot.errors.full_messages }
    end
  end
  
end