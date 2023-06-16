class HomeController < ApplicationController
  def index
    if params[:search].present?
      @open_auctions_lots = Lot.open_auctions.joins(:items).where('lots.code LIKE :search OR items.name LIKE :search',
                                                                  search: "%#{params[:search]}%").distinct
      @future_auctions_lots = Lot.future_auctions.joins(:items).where(
        'lots.code LIKE :search OR items.name LIKE :search', search: "%#{params[:search]}%"
      ).distinct
    else
      @open_auctions_lots = Lot.open_auctions
      @future_auctions_lots = Lot.future_auctions
    end
  end
end
