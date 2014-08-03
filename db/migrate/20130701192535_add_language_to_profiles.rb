class AddLanguageToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :language, :string, :default => "en"
  end
end
