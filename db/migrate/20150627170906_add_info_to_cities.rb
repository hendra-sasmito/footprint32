class AddInfoToCities < ActiveRecord::Migration
  def change
    add_column :cities, :info, :text
  end
end
