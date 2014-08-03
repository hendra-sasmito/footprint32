class AddVisitedPlacesCount < ActiveRecord::Migration
  def up
    add_column :places, :visited_places_count, :integer, :default => 0

    # Place.reset_column_information
    # Place.all.each do |p|
      # p.update_attribute :visited_places_count, p.visited_places.length
    # end
  end

  def down
    remove_column :places, :visited_places_count
  end
end
