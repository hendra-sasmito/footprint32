class AddPhotoableToPhotos < ActiveRecord::Migration
  def change
#    add_column :photos, :photoable, :references, :polymorphic => true, :null => false

    add_column :photos, :photoable_id, :integer, :limit => 11
    add_column :photos, :photoable_type, :string
    add_index :photos, [:photoable_id, :photoable_type]
  end
end
