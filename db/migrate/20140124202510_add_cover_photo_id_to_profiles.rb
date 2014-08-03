class AddCoverPhotoIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :cover_photo_id, :integer
    add_index :profiles, :cover_photo_id
  end
end
