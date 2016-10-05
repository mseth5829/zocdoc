class AppointmentsController < ApplicationController
  before_action :is_authenticated

  def new
    @appointment = Appointment.new
    @current_user = current_user
  end

  def create
    @name = current_user.name
    @appointment = Appointment.new(appointment_params)
    @appointment.patient_id = current_user.id
    if @appointment.save
      redirect_to @appointment
    else
      render 'new'
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @doctor = Appointment.find(@appointment.doctor_id)
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to @appointment
    else
      render "edit"
    end
  end

  def edit
  end

  def destroy
  end

  private
  def appointment_params
    params.require(:appointment).permit(:time, :complaint, :doctor_id)
  end
end
