module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_admin_user

    private

    def verify_admin_user
      unless current_user.admin?
        flash[:alert] = "Você não tem permissão para acessar esta área."
        redirect_to root_path
      end
    end
  end
end
