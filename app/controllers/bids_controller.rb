class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lot, only: [:create]

  def create
    bid = @lot.bids.build(bid_params)
    bid.user = current_user

    if bid.save
      flash[:notice] = 'Lance enviado com sucesso!'
    else
      flash[:alert] = 'Não foi possível enviar o lance.'
      flash[:alert] += ': ' + bid.errors.full_messages.join(', ') unless bid.errors.empty?
    end

    redirect_to lot_path(@lot)
  end

  private

  def set_lot
    @lot = Lot.find(params[:lot_id])
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
