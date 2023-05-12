module Admin
  class LotsController < BaseController
    before_action :set_lot, only: [:edit, :update, :destroy, :add_item, :remove_item, :approve, :cancel, :sell]

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
        set_error_flash('excluir')
      end
      redirect_to root_path
    end
  
    def add_item
      if params[:item_id].blank?
        flash[:alert] = "Nenhum item selecionado. Por favor, selecione um item para adicionar ao lote."
      else
        item = Item.find(params[:item_id])
        if item.update(lot_id: @lot.id)
          flash[:notice] = "Item adicionado ao lote com sucesso"
        else
          set_error_flash('adicionar item ao')
        end
      end
      redirect_to lot_path(@lot)
    end    
  
    def remove_item
      item = Item.find(params[:item_id])
      if item.update(lot_id: nil)
        flash[:notice] = "Item removido do lote com sucesso"
      else
        set_error_flash('remover item do')
      end
      redirect_to lot_path(@lot)
    end

    def approve
      if @lot.update(status: :approved, approver: current_user)
        flash[:notice] = 'Lote aprovado com sucesso'
      else
        set_error_flash('aprovar')
      end
      redirect_to lot_path(@lot)
    end

    #<%= button_to('Cancelar Lote', admin_cancel_lot_path(@lot), method: :patch) if user_signed_in? && current_user.admin? %>
    def cancel
      if @lot.update(status: :canceled)
        @lot.items.update_all(lot_id: nil)
        flash[:notice] = "Lote cancelado com sucesso e itens desassociados"
      else
        set_error_flash('cancelar')
      end
      redirect_to lot_path(@lot)
    end
    
    #<%= link_to('Vender', admin_sell_lot_path(@lot), method: :patch) if user_signed_in? && current_user.admin? %>
    def sell
      if @lot.update(status: :sold)
        flash[:notice] = 'Lote vendido com sucesso'
      else
        set_error_flash('vender')
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

    def set_error_flash(action_name)
      flash[:alert] = "Erro ao #{action_name} lote"
      flash[:alert] += ": " + @lot.errors.full_messages.join(", ") unless @lot.errors.empty?
    end
  
  end
end
