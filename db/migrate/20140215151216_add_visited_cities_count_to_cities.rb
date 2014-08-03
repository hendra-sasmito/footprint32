class AddVisitedCitiesCountToCities < ActiveRecord::Migration
  def change
    add_column :cities, :visited_cities_count, :integer, :default => 0
  end
end
