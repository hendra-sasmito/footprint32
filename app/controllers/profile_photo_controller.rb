class ProfilePhotoController < ApplicationController
  before_filter :authenticate_user_from_token!, :authenticate_user!
  
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
      if current_user.profile_photo != @photo
        current_user.profile_photo = @photo
        current_user.profile.profile_photo_offset_x = 0
        current_user.profile.profile_photo_offset_y = 0
        if current_user.save
          flash[:notice] = t(:photo_updated)
          redirect_to user_profile_path(current_user)
        else
          flash[:notice] = t(:set_profile_fail)
          redirect_to edit_user_profile_path(current_user)
        end
      end
    else
      flash[:notice] = t(:photo_not_found)
      redirect_to edit_user_profile_path(current_user)
    end
  end

  def create
    @photo_album = current_user.photo_albums.find_by_id(params[:photo_album_id])
    if !@photo_album.nil?
      @photo = @photo_album.photos.new(params[:photo])
      @photo.photo_album_id = params[:photo_album_id]
      @photo.creator_id = current_user.id
      if @photo.save
        current_user.profile_photo = @photo
        current_user.profile.profile_photo_offset_x = 0
        current_user.profile.profile_photo_offset_y = 0
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
      format.html { redirect_to edit_user_profile_path(current_user)}
    end

  end

  def save_offset
    puts "-----save offset"
    puts params[:offset_x]
    puts params[:offset_y]
    @user = User.find_by_id(current_user.id)
    if !@user.nil?
      profile = @user.profile
      profile.profile_photo_offset_x = params[:offset_x]
      profile.profile_photo_offset_y = params[:offset_y]
      profile.save!
      flash[:notice] = "Profile photo is updated"
    else
      flash[:notice] = "User is not found"
    end
    respond_to do |format|
      format.js
    end
  end
end
