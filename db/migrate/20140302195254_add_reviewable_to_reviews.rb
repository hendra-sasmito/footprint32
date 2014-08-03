class AddReviewableToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :reviewable_id, :integer, :null => false
    add_column :reviews, :reviewable_type, :string, :null => false
    add_index :reviews, [:reviewable_id, :reviewable_type]
  end
end
