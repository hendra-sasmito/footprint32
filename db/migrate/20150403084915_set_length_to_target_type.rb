class SetLengthToTargetType < ActiveRecord::Migration
  def up
    change_column :activities, :target_type, :string, :limit => 20
  end

  def down
    change_column :activities, :target_type, :string, :limit => nil
  end
end
