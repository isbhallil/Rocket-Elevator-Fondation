class CreateFactIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.int :EmployeeID
      t.int :BuildingID
      t.int :BatteryID (Peut être null)
      t.int :ColumnID (Peut être null)
      t.int :ElevatorID (Peut être null)
      t.string :intervention_begins_at
      t.string :intervention_finished_at
      t.string :result
      t.string :report
      t.string :status
    end
  end
end
