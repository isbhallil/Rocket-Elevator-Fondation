class CreateFactContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_contacts do |t|
      t.string    :contact_id , unique: true
      t.datetime  :creation_date
      t.string    :company_name
      t.string    :email
      t.string    :project_name
    end
  end
end
