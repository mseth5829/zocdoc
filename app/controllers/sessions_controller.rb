class SessionsController < ApplicationController
  def new
  end

  def create
    patient = Patient.authenticate(patient_params)

    if patient
      session[:patient_id] = patient.id
      flash[:success] = "Patient logged in!"
      redirect_to root_path
    else
      flash[:danger] = "Credentials Invalid!"
      redirect_to login_path
    end
  end

  def destroy
    session[:patient_id] = nil
    flash[:success] = "Patient logged out!"
    redirect_to root_path
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :email)
  end
end
