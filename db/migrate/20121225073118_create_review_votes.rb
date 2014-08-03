class CreateReviewVotes < ActiveRecord::Migration
  def change
    create_table :review_votes do |t|
      t.integer :user_id, :null => false
      t.integer :review_id, :null => false
      t.integer :value, :null => false, :default => 0
      t.timestamps
    end
    add_index :review_votes, :review_id
    add_index :review_votes, :user_id
  end
end
