class AddProfilePhotoOffsetToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :ProfilePhotoOffset, :integer, :limit => 2, :default => 0
  end
end
