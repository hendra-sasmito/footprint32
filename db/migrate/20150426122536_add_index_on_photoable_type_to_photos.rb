class AddIndexOnPhotoableTypeToPhotos < ActiveRecord::Migration
  def up
    add_index(:photos, [:photoable_type, :photoable_id, :updated_at], :name => 'index_photos_on_photoable_type', :order => {:updated_at => :desc})
  end

  def down
    remove_index(:photos, :name => 'index_photos_on_photoable_type')
  end
end
