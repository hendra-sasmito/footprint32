class AddLatitudeToCities < ActiveRecord::Migration
  def change
    add_column :cities, :latitude, :float
  end
end
