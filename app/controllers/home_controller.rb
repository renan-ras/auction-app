class HomeController < ApplicationController
  def index
    @open_auctions_lots = Lot.open_auctions
    @future_auctions_lots = Lot.future_auctions
  end
end
