class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show]


  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save()
      redirect_to items_path, notice: 'Item cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Item não cadastrado.'
      render 'new'
    end
  end
  
  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :image, :weight, :width, :height, :depth, :category)
  end
  
end