class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string   :range_type
      t.string   :building_type
      t.string   :full_name
      t.string   :business_name
      t.string   :email
      t.string   :phone_number
      t.string   :building_project_name
      t.string   :project_description
      t.string   :message
      t.string   :departement_in_charge_of_elevators

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

      
      

      t.timestamps
    end
  end
end
