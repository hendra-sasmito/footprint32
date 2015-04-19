class OrderIndexPhotos < ActiveRecord::Migration
  def up
    add_index(:photos, [:creator_id, :updated_at], :order => {:updated_at => :desc})
    add_index(:photos, [:photo_album_id, :updated_at], :order => {:updated_at => :desc})
    add_index(:photos, [:photoable_id, :photoable_type, :updated_at], :name => 'index_photos_on_photoable_id', :order => {:updated_at => :desc})
    remove_index :photos, :creator_id
    remove_index :photos, :photo_album_id
    remove_index :photos, [:photoable_id, :photoable_type]
  end

  def down
    remove_index(:photos, [:creator_id, :updated_at])
    remove_index(:photos, [:photo_album_id, :updated_at])
    remove_index(:photos, :name => 'index_photos_on_photoable_id')
    add_index :photos, :creator_id
    add_index :photos, :photo_album_id
    add_index :photos, [:photoable_id, :photoable_type]
  end
end
