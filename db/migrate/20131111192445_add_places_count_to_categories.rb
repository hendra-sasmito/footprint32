class AddPlacesCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :places_count, :integer, :default => 0
  end
end
