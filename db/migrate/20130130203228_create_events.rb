class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :null => false
      t.integer :creator_id, :null => false
      t.integer :place_id, :null => false
      t.datetime :date, :null => false
      t.integer :privacy, :limit => 1, :default => 0
      t.text :description

      t.timestamps
    end
    add_index :events, :creator_id
    add_index :events, :place_id
  end
end
