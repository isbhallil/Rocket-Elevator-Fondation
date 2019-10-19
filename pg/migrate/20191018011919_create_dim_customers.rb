class CreateDimCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :dim_customers do |t|
      t.string    :customer_id
      t.datetime  :creation_date
      t.string    :company_name
      t.string    :full_name
      t.string    :email
      t.integer   :elevators_count
      t.string    :city
    end
  end
end
