class AddReviewsCountToCities < ActiveRecord::Migration
  def change
    add_column :cities, :reviews_count, :integer, :default => 0
  end
end
