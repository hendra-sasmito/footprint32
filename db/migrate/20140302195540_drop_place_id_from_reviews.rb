class DropPlaceIdFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :place_id
  end

  def down
    add_column :reviews, :place_id
  end
end
