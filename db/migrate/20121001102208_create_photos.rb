class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :creator_id, :null => false
      t.integer :photo_album_id, :null => false
      t.integer :place_id
      t.text :description

      t.timestamps
    end
    add_index :photos, :creator_id
    add_index :photos, :photo_album_id
    add_index :photos, :place_id
  end
end
