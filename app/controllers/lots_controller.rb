class LotsController < ApplicationController
  before_action :set_lot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]


  def show
  end

  def new
    @lot = Lot.new
  end

  def create
    @lot = Lot.new(lot_params)
    @lot.creator = current_user

    if @lot.save()
      redirect_to root_path, notice: 'Lote cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Lote não cadastrado.'
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @lot.update(lot_params)
      redirect_to @lot, notice: 'Lote atualizado com sucesso'
    else
      flash.now[:alert] = "Lote não atualizado"
      render 'edit'
    end
  end
  
  def destroy
    if @lot.destroy
      flash[:notice] = 'Lote removido com sucesso'
    else
      flash[:alert] = "Erro: Lote não removido"
    end
    redirect_to root_path
  end


  private

  def set_lot
    @lot = Lot.find(params[:id])
  end

  def lot_params
    params.require(:lot).permit(:code, :start_date, :end_date, :minimum_bid, :minimum_bid_increment)
  end
  
  def require_admin
    unless current_user.admin?
      flash[:alert] = "Apenas administradores podem realizar esta ação."
      redirect_to root_path
    end
  end

end