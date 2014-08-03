class RemoveCityFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :city
  end

  def down
    add_column :places, :city, :string
  end
end
