class RemovePlaceIdFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :place_id
  end

  def down
    add_column :photos, :place_id, :integer
  end
end
