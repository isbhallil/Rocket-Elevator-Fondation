class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.references :author, foreign_key:  {to_table: :employees} , null: false
      t.references :customer, foreign_key: true
      t.references :building, foreign_key: true
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :employee, foreign_key: true
      t.string :intervention_begins_at
      t.string :intervention_finished_at
      t.string :result, default: 'Incomplete'
      t.text :report
      t.string :status, default: 'Pending'

      t.timestamps
    end
  end
end
