class CreateFavoritePlaces < ActiveRecord::Migration
  def change
    create_table :favorite_places do |t|
      t.integer :user_id, :null => false
      t.integer :place_id, :null => false
      t.timestamps
    end
    add_index :favorite_places, :user_id
    add_index :favorite_places, :place_id
    #add_index :favorite_places, [:user_id, :place_id]
  end
end
