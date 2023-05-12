class LotsController < ApplicationController
  before_action :set_lot, only: [:show]

  def show
  end

  private

  def set_lot
    @lot = Lot.find(params[:id])
  end

end