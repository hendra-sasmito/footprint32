class AddProfilePhotoOffsetYToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_photo_offset_y, :integer, :limit => 2, :default => 0
  end
end
