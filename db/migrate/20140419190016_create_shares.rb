class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :user_id, :null => false
      t.string :provider, :null => false
      t.boolean :share_review, :default => false
      t.boolean :share_event, :default => false
      t.boolean :share_photo, :default => false
      t.timestamps
    end
    add_index :shares, :user_id
  end
end
