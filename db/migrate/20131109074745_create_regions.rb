class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :country_id, :null => false
      t.string :name

#      t.timestamps
    end
    add_index :regions, :country_id
  end
end
