class CoverPhotoController < ApplicationController
  before_filter :authenticate_user!

  def show_photos
    @photos = current_user.photos.page(params[:photo_page]).per(24)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def select_photo
    @photo = current_user.photos.find_by_id(params[:id])
    if !@photo.nil?
      if current_user.cover_photo != @photo
        current_user.cover_photo = @photo
        if current_user.save
          flash[:notice] = t(:photo_updated)
          redirect_to user_profile_path(current_user)
        else
          flash[:notice] = t(:set_profile_fail)
          redirect_to user_profile_path(current_user)
        end
      end
    else
      flash[:notice] = t(:photo_not_found)
      redirect_to user_profile_path(current_user)
    end
  end

  def create
    @photo_album = current_user.photo_albums.find_by_id(params[:photo_album_id])
    if !@photo_album.nil?
      @photo = @photo_album.photos.new(params[:photo])
      @photo.photo_album_id = params[:photo_album_id]
      @photo.creator_id = current_user.id
      if @photo.save
        current_user.cover_photo = @photo
        if current_user.save
          flash[:notice] = t(:photo_updated)
        else
          flash[:notice] = t(:set_profile_fail)
        end
      else
        flash[:notice] = t(:set_profile_fail)
      end
    else
      flash[:notice] = t(:photo_album_not_found)
    end

    respond_to do |format|
      format.html { redirect_to user_profile_path(current_user)}
    end

  end
end
