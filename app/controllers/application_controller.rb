class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_authenticated
    unless current_user
      flash[:danger] = "Credentials Invalid!"
      redirect_to login_path
    end
  end

  # def is_authenticated_admin
  #   unless current_user.is_admin
  #     flash[:danger] = "Credentials Invalid!"
  #     redirect_to login_path
  #   end
  # end

  def current_user
    @current_user ||= Patient.find_by_id(session[:patient_id])
  end

  def change_index
    current_user
  end
end
