class AddAlbumableToPhotoAlbums < ActiveRecord::Migration
  def change
    add_column :photo_albums, :albumable_id, :integer
    add_column :photo_albums, :albumable_type, :string
    add_index :photo_albums, [:albumable_id, :albumable_type]
  end
end
