class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id, :null => false
      t.integer :friend_id, :null => false
      t.string :status, :null => false

      t.datetime :accepted_at
      t.timestamps
    end
    add_index :friendships, [:user_id, :friend_id]
#    add_index :friendships, :user_id
#    add_index :friendships, :friend_id

    #add_index :friendships, :status
  end
end
