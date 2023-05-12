module Admin
  class ItemsController < BaseController
    before_action :set_item, only: [:edit, :update, :destroy]

    def new
      @item = Item.new
    end

    def create
      @item = Item.new(item_params)

      if @item.save
        redirect_to items_path, notice: 'Item cadastrado com sucesso.'
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
