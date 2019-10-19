class CreateFactQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_quotes do |t|
      t.integer   :quote_id , unique: true
      t.datetime  :submited_at
      t.string    :company_name
      t.string    :email
      t.integer   :elevators_count
    end
  end
end
