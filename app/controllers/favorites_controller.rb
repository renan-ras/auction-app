class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    lot = Lot.find(params[:lot_id])
    current_user.favorite_lots << lot
    redirect_to lot_path(lot), notice: 'Lote adicionado aos favoritos.'
  end

  def destroy
    lot = Lot.find(params[:lot_id])
    current_user.favorite_lots.delete(lot)
    redirect_to lot_path(lot), notice: 'Lote removido dos favoritos.'
  end
end
