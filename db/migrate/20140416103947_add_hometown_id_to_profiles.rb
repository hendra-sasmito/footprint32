class AddHometownIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :hometown_id, :integer
    add_index :profiles, :hometown_id
  end
end
