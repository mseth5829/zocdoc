class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.integer :time
      t.string :complaint

      t.timestamps
    end
  end
end
