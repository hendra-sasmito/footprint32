class AddDefaultToPhotoAlbum < ActiveRecord::Migration
  def change
    add_column :photo_albums, :default, :boolean, :default => false
  end
end
