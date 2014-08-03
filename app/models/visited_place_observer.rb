class VisitedPlaceObserver < ActiveRecord::Observer
  def after_save(visited_place)
    Activity.add(visited_place.user, Activity::CHANGE_LOCATION, visited_place, visited_place)
  end

  def before_destroy(visited_place)
    Activity.destroy_all(:activity_type => Activity::CHANGE_LOCATION, :target_id => visited_place.id)
  end
end
