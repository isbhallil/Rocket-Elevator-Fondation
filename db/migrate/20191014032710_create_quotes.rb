class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string   :range_type
      t.string   :building_type
      t.integer  :units
      t.integer  :stories
      t.integer  :basements
      t.integer  :parking_spaces
      t.integer  :max_occupants
      t.integer  :hours


      t.integer  :elevator_shafts
      t.float    :elevator_unit_cost
      t.float    :setup_fees
      t.float    :total

      t.string   :contact
      t.string   :phone

      t.timestamps
    end
  end
end
