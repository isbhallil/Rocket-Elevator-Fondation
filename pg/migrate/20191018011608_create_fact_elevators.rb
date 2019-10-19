class CreateFactElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_elevators do |t|
      t.string :elevator_id, unique: true
      t.string :serial_number, unique: true
      t.string :commissioning
      t.string :building_id
      t.string :customer_id
      t.string :city # of the building
    end
  end
end
