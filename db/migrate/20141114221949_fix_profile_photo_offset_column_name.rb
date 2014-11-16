class FixProfilePhotoOffsetColumnName < ActiveRecord::Migration
  def up
    rename_column :profiles, :ProfilePhotoOffset, :profile_photo_offset_x
  end

  def down
    rename_column :profiles, :profile_photo_offset_x, :ProfilePhotoOffset
  end
end
