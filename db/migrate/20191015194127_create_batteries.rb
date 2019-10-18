class CreateBatteries < ActiveRecord::Migration[5.2]
  def change
    create_table :batteries do |t|
      t.references :building, foreign_key: {on_delete: :cascade, on_update: :cascade}, null: false
      t.references :employee, foreign_key: {on_delete: :cascade, on_update: :cascade}
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
