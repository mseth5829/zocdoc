class AppointmentsController < ApplicationController
  before_action :is_authenticated

  def new
    @appointment = Appointment.new
    @current_user = current_user
  end

  def create
    @name = current_user.name
    @appointment = Appointment.new(appointment_params)
    appointmentExists = Appointment.where(doctor_id: params[:appointment][:doctor_id], time: params[:time])
    puts "APPTEXISTS/not :" + appointmentExists.inspect

    if appointmentExists.present?
      flash.now[:danger] = "Appointment is taken :("
      render 'new'
    else
      @appointment.patient_id = current_user.id
      @appointment.time = params[:time]
      if @appointment.save
        redirect_to root_path
      else
        render 'new'
      end
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    @doctor = Appointment.find(@appointment.doctor_id)
  end

  def update
    @appointment = Appointment.find(params[:id])
    appointmentExists = Appointment.where(doctor_id: params[:appointment][:doctor_id], time: params[:time])

    if appointmentExists
      flash[:danger] = "Appointment is taken :("
      render 'new'
    else
      if @appointment.update(appointment_params)
        @appointment.time = params[:time]
        redirect_to @appointment
      else
        render "edit"
      end
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @doctor = Appointment.find(@appointment.doctor_id)
  end

  def destroy
    Appointment.find(params[:id]).delete
    redirect_to patient_path
  end

  private
  def appointment_params
    params.require(:appointment).permit(:time, :complaint, :doctor_id)
  end
end
