class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, :null => false
#      t.integer :commentable_id
#      t.string :commentable_type
      t.references :commentable, :polymorphic => true, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
#    add_index :comments, :commentable_id
#    add_index :comments, :commentable_type
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
  end
end
