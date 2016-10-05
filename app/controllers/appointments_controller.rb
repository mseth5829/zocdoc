class AppointmentsController < ApplicationController
  before_action :is_authenticated

  def new
    @appointment = Appointment.new
    @current_user = current_user
  end

  def create
    @name = current_user.name
    @appointment = Appointment.new(appointment_params)

    if @appointment.doctor_id && @appointment.time
      puts "created, saving to db"
      render 'new'
    else
      puts "2..."
      @appointment.patient_id = current_user.id
      if @appointment.save
        puts "3..."
        redirect_to @appointment
      else
        puts "4..."
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
    if @appointment.doctor_id && @appointment.time
      render 'new'
    else
      if @appointment.update(appointment_params)
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
