class OrderIndexEvents < ActiveRecord::Migration
  def up
    add_index(:events, [:creator_id, :date], :order => {:date => :asc})
    add_index(:events, [:place_id, :date], :order => {:date => :asc})
    remove_index :events, :creator_id
    remove_index :events, :place_id
  end

  def down
    remove_index(:events, [:creator_id, :date])
    remove_index(:events, [:place_id, :date])
    add_index :events, :creator_id
    add_index :events, :place_id
  end
end
