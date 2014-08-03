class AddFavoriteCitiesCountToCities < ActiveRecord::Migration
  def change
    add_column :cities, :favorite_cities_count, :integer, :default => 0
  end
end
