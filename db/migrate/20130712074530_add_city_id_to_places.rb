class AddCityIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :city_id, :integer, :null => false
    add_index :places, :city_id
  end
end
