class SetLengthToReportableType < ActiveRecord::Migration
  def up
    change_column :reports, :reportable_type, :string, :limit => 20
  end

  def down
    change_column :reports, :reportable_type, :string, :limit => nil
  end
end
