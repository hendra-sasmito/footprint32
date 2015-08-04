class PhotoAlbumObserver < ActiveRecord::Observer
  def before_destroy(photo_album)
    photo_album.photos.each do |photo|
#      Activity.destroy_all(:activity_type => Activity::UPLOAD_PHOTO, :target_id => photo.id)
    end
  end
end
