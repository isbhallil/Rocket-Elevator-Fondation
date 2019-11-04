class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.references :customer, foreign_key: true
      t.string :full_name
      t.string :business_name
      t.string :email
      t.string :phone_number
      t.string :building_project_name
      t.string :project_description
      t.string :building_type
      t.string :message
      t.string :original_filename
      t.timestamps
    end
  end
end
