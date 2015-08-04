class VisitedCityObserver < ActiveRecord::Observer
  def after_save(visited_city)
    Activity.add(visited_city.user, Activity::ADD_VISITED_CITY, visited_city, visited_city)
  end

  def before_destroy(visited_place)
    Activity.destroy_all(:activity_type => Activity::ADD_VISITED_CITY, :target_id => visited_city.id)
  end
end
