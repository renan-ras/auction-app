module Admin
  class ItemsController < BaseController
    before_action :set_item, only: [:edit, :update, :destroy]

    def lotless_items
      @items = Item.where(lot_id: nil) # Itens não associados a lotes
    end

    def sold_items
      @items = Item.in_sold_lots
    end

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)

      if @item.save
        redirect_to @item, notice: 'Item cadastrado com sucesso.'
      else
        flash.now[:alert] = 'Item não cadastrado.'
        render 'new'
      end
    end

    def edit
    end

    def update
      if @item.update(item_params)
        redirect_to @item, notice: 'Item atualizado com sucesso'
      else
        flash.now[:alert] = "Item não atualizado"
        render 'edit'
      end
    end

    def destroy
      if @item.destroy
        flash[:notice] = 'Item removido com sucesso'
      else
        flash[:alert] = "Item não removido"
        flash[:alert] += ": " + @item.errors.full_messages.join(", ") unless @item.errors.empty?
      end
      redirect_to items_path
    end

    private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :weight, :width, :height, :depth, :category, :image)
    end
  end
end
