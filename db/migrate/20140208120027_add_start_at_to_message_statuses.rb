class AddStartAtToMessageStatuses < ActiveRecord::Migration
  def change
    add_column :message_statuses, :start_at, :integer
    add_index :message_statuses, :start_at
  end
end
