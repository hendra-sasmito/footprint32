class SetLengthToPhotoableType < ActiveRecord::Migration
  def up
    change_column :photos, :photoable_type, :string, :limit => 20
  end

  def down
    change_column :photos, :photoable_type, :string, :limit => nil
  end
end
