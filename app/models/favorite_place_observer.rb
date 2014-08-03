class FavoritePlaceObserver < ActiveRecord::Observer

  def after_save(favorite_place)
    Activity.add(favorite_place.user, Activity::ADD_FAVORITE_PLACE, favorite_place, favorite_place)
  end

  def before_destroy(favorite_place)
    Activity.destroy_all(:activity_type => Activity::ADD_FAVORITE_PLACE,:target_id => favorite_place.id)
  end
end
