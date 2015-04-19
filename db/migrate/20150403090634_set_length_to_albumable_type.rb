class SetLengthToAlbumableType < ActiveRecord::Migration
  def up
    change_column :photo_albums, :albumable_type, :string, :limit => 20
  end

  def down
    change_column :photo_albums, :albumable_type, :string, :limit => nil
  end
end
