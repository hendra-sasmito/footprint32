module PhotoAlbumsHelper

  # get cover photo of album
  def get_album_cover(album)
    if (album.photos.count > 0)
      #cover = album.photos.offset(rand(album.photos.count)).first
      cover = album.photos.last
      return cover.image.url(:small)
    else
      return "camera-128.png"
    end
  end
end
