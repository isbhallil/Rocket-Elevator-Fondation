class CreateElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :elevators do |t|
      t.references :column, foreign_key: {on_delete: :cascade, on_update: :cascade}, null: false
      t.string :serial_number, null: false
      t.string :model_type, null: false
      t.string :building_type, null: false
      t.string :status
      t.date :date_of_installation
      t.date :date_of_inspection
      t.string :inspection_certificate
      t.text :information
      t.text :notes
      
      t.timestamps
    end
  end
end
