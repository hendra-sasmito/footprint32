class PhotoObserver < ActiveRecord::Observer
  def after_create(photo)
    Activity.add(photo.creator, Activity::UPLOAD_PHOTO, photo, photo) if photo.photo_album.privacy != "private"
  end

  def before_destroy(photo)
    Activity.destroy_all(:activity_type => Activity::UPLOAD_PHOTO, :target_id => photo.id)
  end
end
