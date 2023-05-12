module Admin
  class LotsController < BaseController
    before_action :set_lot, only: [:edit, :update, :destroy, :add_item, :remove_item, :approve]

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
        flash[:alert] = "Lote não removido"
      end
      redirect_to root_path
    end
  
    def add_item
      if params[:item_id].blank?
        flash[:alert] = "Nenhum item selecionado. Por favor, selecione um item para adicionar ao lote."
        redirect_to lot_path(@lot)
        return
      end
    
      item = Item.find(params[:item_id])
      if item.update(lot_id: @lot.id)
        flash[:notice] = "Item adicionado ao lote com sucesso"
      else
        flash[:alert] = "Erro ao adicionar item ao lote"
      end
      redirect_to lot_path(@lot)
    end    
  
    def remove_item
      item = Item.find(params[:item_id])
      if item.update(lot_id: nil)
        flash[:notice] = "Item removido do lote com sucesso"
      else
        flash[:alert] = "Erro ao remover item do lote"
      end
      redirect_to lot_path(@lot)
    end

    def approve
      if @lot.update(status: :approved, approver: current_user)
        flash[:notice] = 'Lote aprovado com sucesso'
      else
        flash[:alert] = 'Erro ao aprovar o lote'
        flash[:alert] += ": " + @lot.errors.full_messages.join(", ") unless @lot.errors.empty?
      end
      redirect_to lot_path(@lot)
    end

    private
  
    def set_lot
      @lot = Lot.find(params[:id])
    end
  
    def lot_params
      params.require(:lot).permit(:code, :start_date, :end_date, :minimum_bid, :minimum_bid_increment)
    end
  
  end
end
