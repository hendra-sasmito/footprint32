class AddPlacesCountToCities < ActiveRecord::Migration
  def change
    add_column :cities, :places_count, :integer, :default => 0
  end
end
