class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end
  end
end
