class CreateVisitedPlaces < ActiveRecord::Migration
  def change
    create_table :visited_places do |t|
      t.integer :user_id, :null => false
      t.integer :place_id, :null => false
      t.timestamps
    end
    add_index :visited_places, :user_id
    add_index :visited_places, :place_id
    #add_index :visited_places, [:user_id, :place_id]
  end
end
