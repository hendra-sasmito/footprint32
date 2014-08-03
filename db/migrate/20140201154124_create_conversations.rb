class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :message_id, :null => false
      t.integer :sender_id, :null => false
      t.text :content

      t.timestamps
    end
    add_index :conversations, :message_id
    add_index :conversations, :sender_id
  end
end
