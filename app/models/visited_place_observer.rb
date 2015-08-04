class VisitedPlaceObserver < ActiveRecord::Observer
  def after_save(visited_place)
    Activity.add(visited_place.user, Activity::ADD_VISITED_PLACE, visited_place, visited_place)
  end

  def before_destroy(visited_place)
    Activity.destroy_all(:activity_type => Activity::ADD_VISITED_PLACE, :target_id => visited_place.id)
  end
end
