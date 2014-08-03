class CreateMessageStatuses < ActiveRecord::Migration
  def change
    create_table :message_statuses do |t|
      t.integer :message_id, :null => false
      t.integer :user_id, :null => false
      t.integer :status, :null => false

      t.timestamps
    end
    add_index :message_statuses, :message_id
    add_index :message_statuses, :user_id
  end
end
