class AddLongitudeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :longitude, :float
  end
end
