class FavoriteCityObserver < ActiveRecord::Observer

  def after_save(favorite_city)
    Activity.add(favorite_city.user, Activity::ADD_FAVORITE_CITY, favorite_city, favorite_city)
  end

  def before_destroy(favorite_city)
    Activity.destroy_all(:activity_type => Activity::ADD_FAVORITE_CITY,:target_id => favorite_city.id)
  end

end
