module PlacesHelper
  unloadable
  include CategoriesHelper
  include ActionView::Helpers::AssetTagHelper

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
  
  # get thumbnail photo of place or city
  def place_thumb_photo(place)
    if (place.photos.public_photo.count > 0)
      return place.photos.public_photo.last.image.url(:thumb)
    else
      return ActionController::Base.helpers.image_path('city.png')
    end
  end

  def place_small_photo(place)
    if (place.photos.public_photo.count > 0)
      return place.photos.public_photo.last.image.url(:small)
    else
      return ActionController::Base.helpers.image_path('city.png')
    end
  end

  # get cover photo of place
  def place_cover_photo(place)
    if (place.photos.public_photo.count > 0)
      return place.photos.public_photo.last.image.url(:original)
    else
      return ActionController::Base.helpers.image_path('Transparent.png')
    end
  end

  # get place photo
  def get_place_photo(place)
    if (place.photos.public_photo.count > 0)
      return place.photos.public_photo.offset(rand(place.photos.public_photo.count)).first
      return place.photos.public_photo.first.image.url(:original)
    else
      return ActionController::Base.helpers.image_path('Transparent.png')
    end
  end
end
