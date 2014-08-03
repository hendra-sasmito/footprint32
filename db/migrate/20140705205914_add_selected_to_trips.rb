class AddSelectedToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :selected, :boolean, :default => false
  end
end
