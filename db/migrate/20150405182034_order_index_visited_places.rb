class OrderIndexVisitedPlaces < ActiveRecord::Migration
  def up
    add_index(:visited_places, [:user_id, :updated_at], :order => {:updated_at => :desc})
    add_index(:visited_places, [:place_id, :updated_at], :order => {:updated_at => :desc})
    remove_index(:visited_places, :user_id)
    remove_index(:visited_places, :place_id)
  end

  def down
    remove_index(:visited_places, [:user_id, :updated_at])
    remove_index(:visited_places, [:place_id, :updated_at])
    add_index(:visited_places, :user_id)
    add_index(:visited_places, :place_id)
  end
end
