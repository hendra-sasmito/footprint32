class OrderIndexReviews < ActiveRecord::Migration
  def up
    add_index(:reviews, [:creator_id, :updated_at], :order => {:updated_at => :desc})
    add_index(:reviews, [:reviewable_id, :reviewable_type, :updated_at], :name => 'index_reviews_on_reviewable_id', :order => {:updated_at => :desc})
    remove_index :reviews, :creator_id
    remove_index :reviews, [:reviewable_id, :reviewable_type]
  end

  def down
    remove_index(:reviews, [:creator_id, :updated_at])
    remove_index(:reviews, :name => 'index_reviews_on_reviewable_id')
    add_index :reviews, :creator_id
    add_index :reviews, [:reviewable_id, :reviewable_type]
  end
end
