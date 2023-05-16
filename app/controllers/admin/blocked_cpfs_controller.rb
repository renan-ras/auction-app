class Admin::BlockedCpfsController < ApplicationController
  before_action :set_blocked_cpf, only: [:edit, :update, :destroy]

  def index
    @blocked_cpfs = BlockedCpf.all
  end

  def new
    @blocked_cpf = BlockedCpf.new
  end

  def create
    @blocked_cpf = BlockedCpf.new(blocked_cpf_params)
    @blocked_cpf.blocked_by = current_user
    if @blocked_cpf.save
      redirect_to admin_blocked_cpfs_path, notice: 'CPF bloqueado com sucesso.'
    else
      flash[:alert] = 'Falha ao bloquear CPF.'
      render :new
    end
  end

  def edit
  end

  def update
    if @blocked_cpf.update(blocked_cpf_params)
      redirect_to admin_blocked_cpfs_path, notice: 'Bloqueio atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @blocked_cpf.destroy
    redirect_to admin_blocked_cpfs_path, notice: 'CPF desbloqueado com sucesso.'
  end

  private

  def set_blocked_cpf
  @blocked_cpf = BlockedCpf.find(params[:id])
  end
  
  def blocked_cpf_params
  params.require(:blocked_cpf).permit(:cpf, :reason)
  end

end
