class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, :null => false
      t.string :street
      t.string :city
      t.string :postcode
      t.string :country
      t.float :latitude, :null => false
      t.float :longitude, :null => false

      t.timestamps
    end
  end
end
