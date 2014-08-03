class ProfilePhotoObserver < ActiveRecord::Observer
  def after_save(profile_photo)
    Activity.add(profile_photo.user, Activity::CHANGE_PROFILE_PHOTO, profile_photo, profile_photo.photo) if profile_photo.photo != nil
  end

  def before_destroy(profile_photo)
    Activity.destroy_all(:activity_type => Activity::CHANGE_PROFILE_PHOTO, :target_id => profile_photo.id)
  end
end
