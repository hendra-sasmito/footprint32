class AddFavoritePlacesCount < ActiveRecord::Migration
  def up
    add_column :places, :favorite_places_count, :integer, :default => 0

    # Place.reset_column_information
    # Place.all.each do |p|
      # p.update_attribute :favorite_places_count, p.favorite_places.length
    # end
  end

  def down
    remove_column :places, :favorite_places_count
  end
end
