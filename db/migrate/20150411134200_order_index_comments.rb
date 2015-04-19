class OrderIndexComments < ActiveRecord::Migration
  def up
    add_index(:comments, [:commentable_id, :commentable_type, :created_at], :name => 'index_comments_on_commentable_id', :order => {:created_at => :desc})
    add_index(:comments, [:user_id, :created_at], :order => {:created_at => :desc})
    remove_index(:comments, [:commentable_id, :commentable_type])
    remove_index(:comments, [:user_id])
  end

  def down
    remove_index(:comments, :name => 'index_comments_on_commentable_id')
    remove_index(:comments, [:user_id, :created_at])
    add_index(:comments, [:commentable_id, :commentable_type])
    add_index(:comments, [:user_id])
  end
end
