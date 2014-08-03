class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :region_id, :null => false
      t.integer :country_id, :null => false
      t.string :name, :null => false
      
#      t.timestamps
    end
    add_index :cities, [:region_id, :country_id]
  end
end
