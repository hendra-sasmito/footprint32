class OrderIndexCities < ActiveRecord::Migration
  def up
    add_index(:cities, [:country_id, :places_count], :name => 'index_cities_on_places_count', :order => {:places_count => :desc})
    remove_index :cities, [:region_id, :country_id]
  end

  def down
    remove_index(:cities, :name => 'index_cities_on_places_count')
    add_index :cities, [:region_id, :country_id]
  end
end
