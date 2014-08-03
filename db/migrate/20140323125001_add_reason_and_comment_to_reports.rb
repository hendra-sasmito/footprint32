class AddReasonAndCommentToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reason, :integer, :null => false
    add_column :reports, :comment, :text
  end
end
