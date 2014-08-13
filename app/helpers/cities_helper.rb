module CitiesHelper

  def get_small_photo_url(photo)
    if !photo.first.nil?
      return photo.first.image.url(:small)
    else
      return ActionController::Base.helpers.image_path('city.png')
    end
  end

  def get_thumb_photo_url(photo)
    if !photo.first.nil?
      return photo.first.image.url(:thumb)
    else
      return ActionController::Base.helpers.image_path('city.png')
    end
  end

end
