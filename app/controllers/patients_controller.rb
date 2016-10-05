class PatientsController < ApplicationController
  def show
    puts "MATCHED ROUTE"
    @patient = Patient.find(params[:id])
    @appointments = @patient.appointments
  end

  def delete
  end

  def new
    @patient = Patient.new
  end

  def create
    # puts patient_params.inspect

    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def patient_params
      params.require(:patient).permit(:name, :email, :password)
    end
end
