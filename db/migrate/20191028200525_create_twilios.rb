class CreateTwilios < ActiveRecord::Migration[5.2]
  def change
    create_table :twilios do |t|

      t.timestamps
    end
  end
end
