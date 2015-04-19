class SetLengthToReviewableType < ActiveRecord::Migration
  def up
    change_column :reviews, :reviewable_type, :string, :limit => 20
  end

  def down
    change_column :reviews, :reviewable_type, :string, :limit => nil
  end
end
