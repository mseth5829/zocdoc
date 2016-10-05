class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :time, :inclusion => 9..16
end
