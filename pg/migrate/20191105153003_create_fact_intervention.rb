class CreateFactIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.integer :EmployeeID
      t.integer :BuildingID
      t.integer :BatteryID
      t.integer :ColumnID
      t.integer :ElevatorID
      t.string :intervention_begins_at
      t.string :intervention_finished_at
      t.string :result
      t.string :report
      t.string :status
    end
  end
end
