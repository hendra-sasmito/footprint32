class RemoveCoverPhotoIdFromProfiles < ActiveRecord::Migration
  def up
    remove_column :profiles, :cover_photo_id
  end

  def down
    add_column :profiles, :cover_photo_id, :integer
  end
end
