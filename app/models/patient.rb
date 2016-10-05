class Patient < ApplicationRecord

  has_many :appointments
  has_many :doctors, through: :appointments

  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false}

  validates :password,
            length: { in: 8..72 }, on: :create

  has_secure_password

  def self.authenticate(params)
    Patient.find_by_email(params[:email]).try(:authenticate, params[:password])
  end
end
