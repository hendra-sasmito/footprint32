class CreateFavoriteCities < ActiveRecord::Migration
  def change
    create_table :favorite_cities do |t|
      t.integer :user_id, :null => false
      t.integer :city_id, :null => false

      t.timestamps
    end
    add_index :favorite_cities, :user_id
    add_index :favorite_cities, :city_id
  end
end
