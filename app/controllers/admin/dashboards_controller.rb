class Admin::DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    @lots_pending_approval = Lot.pending_approval
    @lots_auction_ended = Lot.where(status: :approved).where('end_date < ?', Time.now)
    @questions = Question.where(answer: nil)
  end

  private

  def ensure_admin
    return if current_user.admin?

    redirect_to root_path, alert: 'Acesso negado'
  end
end
