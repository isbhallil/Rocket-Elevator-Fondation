class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string    'range-type'
      t.string    'building-type'
      t.integer   'units'
      t.integer   'stories'
      t.integer   'basements'
      t.integer   'parking-spaces'
      t.integer   'max-occupants'
      t.integer   'hours'
      

      t.integer   'elevator-shafts'
      t.float     'elevator-unit-cost'
      t.float     'setup-fees'
      t.float     'total'
      
      t.string    'contact'
      t.string    'phone'

      t.timestamps
    end
  end
end
