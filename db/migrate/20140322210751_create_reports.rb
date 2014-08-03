class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id, :null => false
      t.integer :reportable_id, :null => false
      t.string :reportable_type, :null => false

      t.timestamps
    end
    add_index :reports, [:reportable_id, :reportable_type]
    add_index :reports, :user_id
  end
end
