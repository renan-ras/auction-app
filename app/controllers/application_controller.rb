class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_blocked_cpf

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname cpf])
  end

  def check_blocked_cpf
    return unless current_user && BlockedCpf.exists?(cpf: current_user.cpf)

    sign_out current_user
    flash[:alert] = 'Sua conta está suspensa.'
    redirect_to root_path
  end
end
