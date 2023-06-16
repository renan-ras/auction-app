class LotsController < ApplicationController
  before_action :set_lot, only: [:show]

  def show
    @available_items = Lot.available_items
  end

  private

  def set_lot
    @lot = Lot.find(params[:id])
  end
end
