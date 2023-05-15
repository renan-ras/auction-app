class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @won_auction_lots = Lot.won_by_user(current_user)

    @bidden_lots = Lot.joins(:bids).where(bids: { user_id: current_user.id }).distinct
  end
end
