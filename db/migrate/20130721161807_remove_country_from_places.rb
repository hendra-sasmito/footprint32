class RemoveCountryFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :country
  end

  def down
    add_column :places, :country, :string
  end
end
