class OrderIndexVisitedCities < ActiveRecord::Migration
  def up
    add_index(:visited_cities, [:user_id, :updated_at], :order => {:updated_at => :desc})
    add_index(:visited_cities, [:city_id, :updated_at], :order => {:updated_at => :desc})
    remove_index(:visited_cities, :user_id)
    remove_index(:visited_cities, :city_id)
  end

  def down
    remove_index(:visited_cities, [:user_id, :updated_at])
    remove_index(:visited_cities, [:city_id, :updated_at])
    add_index(:visited_cities, :user_id)
    add_index(:visited_cities, :city_id)
  end
end
