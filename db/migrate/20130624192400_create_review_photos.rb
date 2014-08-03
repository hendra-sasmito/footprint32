class CreateReviewPhotos < ActiveRecord::Migration
  def change
    create_table :review_photos do |t|
#      t.integer :place_id, :null => false
      t.integer :review_id, :null => false
      t.timestamps
    end
#    add_index :review_photos, :place_id
    add_index :review_photos, :review_id
  end
end
