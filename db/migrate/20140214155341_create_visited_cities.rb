class CreateVisitedCities < ActiveRecord::Migration
  def change
    create_table :visited_cities do |t|
      t.integer :user_id, :null => false
      t.integer :city_id, :null => false

      t.timestamps
    end
    add_index :visited_cities, :user_id
    add_index :visited_cities, :city_id
  end
end
