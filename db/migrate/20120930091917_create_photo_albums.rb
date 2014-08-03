class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.integer :creator_id, :null => false
      t.string :name, :null => false
      t.text :description
      t.integer :privacy, :limit => 1, :default => 0
      t.timestamps
    end
    add_index :photo_albums, :creator_id
  end
end
