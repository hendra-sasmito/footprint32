class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, :unique => true
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.date :birthdate
      t.string :gender, :limit => 1
      t.text :about
      t.integer :profile_photo_id
      t.integer :location_id
      t.timestamps
    end
    add_index :profiles, :user_id
    add_index :profiles, :profile_photo_id
    add_index :profiles, :location_id
  end
end
