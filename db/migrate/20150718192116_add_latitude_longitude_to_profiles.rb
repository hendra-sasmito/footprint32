class AddLatitudeLongitudeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :latitude, :float
    add_column :profiles, :longitude, :float
    add_column :profiles, :share_location, :boolean, :default => false
  end
end
