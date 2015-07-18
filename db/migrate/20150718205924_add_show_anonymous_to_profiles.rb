class AddShowAnonymousToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :show_anonymous, :boolean, :default => false
  end
end
