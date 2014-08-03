class AddAttachmentDatalogToTrips < ActiveRecord::Migration
  def self.up
    change_table :trips do |t|
      t.has_attached_file :datalog
    end
  end

  def self.down
    drop_attached_file :trips, :datalog
  end
end
