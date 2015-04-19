class OrderIndexMessageStatuses < ActiveRecord::Migration
  def up
    add_index(:message_statuses, [:user_id, :status])
    add_index(:message_statuses, [:message_id, :status])
    remove_index :message_statuses, :user_id
    remove_index :message_statuses, :message_id
    remove_index :message_statuses, :start_at
  end

  def down
    remove_index(:message_statuses, [:user_id, :status])
    remove_index(:message_statuses, [:message_id, :status])
    add_index :message_statuses, :user_id
    add_index :message_statuses, :message_id
    add_index :message_statuses, :start_at
  end
end
