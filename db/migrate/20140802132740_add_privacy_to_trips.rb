class AddPrivacyToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :privacy, :integer, :limit => 1, :default => 0
  end
end
