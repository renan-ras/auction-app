class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

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
      flash[:alert] = "Erro: Item não removido"
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
  
  def require_admin
    unless current_user.admin?
      flash[:alert] = "Apenas administradores podem realizar esta ação."
      redirect_to items_path
    end
  end

end