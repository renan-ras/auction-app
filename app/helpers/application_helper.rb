module ApplicationHelper
  def user_status
    if user_signed_in?
      if current_user.admin?
        'admin'
      else
        'usuário'
      end
    else
      'visitante'
    end
  end
end
