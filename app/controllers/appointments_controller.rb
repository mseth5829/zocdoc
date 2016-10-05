class AppointmentsController < ApplicationController
  before_action :is_authenticated

  def new
    @appointment = Appointment.new
    @current_user = current_user
  end

  def create
    @name = current_user.name
    
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end
end
