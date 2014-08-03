class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, :null => false
      t.string :code, :limit => 2, :null => false
      t.integer :cities_count, :default => 0
#      t.timestamps
    end
  end
end
