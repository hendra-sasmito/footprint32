class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :creator_id, :null => false
      t.integer :place_id, :null => false
      t.text :content, :null => false
#      t.references :reviewable, :polymorphic => true, :null => false
      t.timestamps
    end
    add_index :reviews, :creator_id
#    add_index :reviews, [:reviewable_id, :reviewable_type]
  end
end
