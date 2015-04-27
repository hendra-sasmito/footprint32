class AddIndexOnReviewableTypeToReviews < ActiveRecord::Migration
  def up
    add_index(:reviews, [:reviewable_type, :reviewable_id, :updated_at], :name => 'index_reviews_on_reviewable_type', :order => {:updated_at => :desc})
  end

  def down
    remove_index(:reviews, :name => 'index_reviews_on_reviewable_type')
  end
end
