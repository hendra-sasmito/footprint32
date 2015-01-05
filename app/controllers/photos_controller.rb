class PhotosController < ApplicationController
  before_filter :authenticate_user!
  require 'exifr'
  
  # GET /photos/1
  # GET /photos/1.json
  def show
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @photo_album = @user.photo_albums.find_by_id(params[:photo_album_id])
      if !@photo_album.nil?
        if is_user_allowed(@user, @photo_album.privacy)
          @photo = @photo_album.photos.find_by_id(params[:id])
          @comment = Comment.new
          @photoable = @photo.photoable
          @commentable = @photo
          @comments = @photo.comments.includes(:user => [:profile, :profile_photo]).order("created_at DESC").page(params[:comment_page]).per(5)
          @photo_exif = get_exif_info(@photo)
        else
          flash[:notice] = t(:not_allowed)
          return redirect_to user_photo_album_path(@user, @photo_album)
        end
      else
        flash[:notice] = t(:photo_album_not_found)
        return redirect_back_or_default(user_photo_albums_path(@user))
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
      format.js
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        # only logged in user can create new photo
        @photo_album = @user.photo_albums.find_by_id(params[:photo_album_id])
        if !@photo_album.nil?
          @photo = @photo_album.photos.new
        else
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
      else
        flash[:notice] = t(:not_allowed)
        return redirect_back_or_default()
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        # only logged in user can edit photo
        @photo_album = @user.photo_albums.find_by_id(params[:photo_album_id])
        if !@photo_album.nil?
          @photo = @photo_album.photos.find_by_id(params[:id])
          if @photo.nil?
            flash[:notice] = t(:photo_not_found)
            return redirect_to user_photo_album_path(@user, @photo_album)
          end
        else
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
      else
        flash[:notice] = t(:not_allowed)
        return redirect_back_or_default()
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        # only logged in user can create new photo
        @photo_album = @user.photo_albums.find_by_id(params[:photo_album_id])
        if !@photo_album.nil? and params[:photo]
          @photo = @photo_album.photos.new(params[:photo])
          @photo.description = params[:description] if params[:description]
          @photo.photoable_id = params[:photoable_id] if params[:photoable_id]
          @photo.photoable_type = params[:photoable_type] if params[:photoable_type]
          @photo.creator_id = @photo_album.creator_id
          @photoable = params[:photoable_id] if params[:photoable_id]

          shared = false
          share = current_user.shares.find_by_provider("facebook")
          if !share.nil?
            if share.share_photo == true
              shared = true
            end
          end
        else
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
      else
        flash[:notice] = t(:not_allowed)
        return redirect_back_or_default()
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
#      if @photo.save
#        format.html { redirect_to user_photo_album_photo_path(@user, @photo_album, @photo), :gflash => { :notice => { :value => "Photo was successfully created.", :time => Footprint32::GRITTER_TIME } }}
#        format.json { render json: @photo, status: :created, location: @photo }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @photo.errors, status: :unprocessable_entity }
#      end
      if @photo.save
        format.html {
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        if shared
          @content = @photo.description
          @link = user_photo_album_photo_url(@user, @photo_album, @photo)
          @name = "www.koedok.com"
          FbshareWorker.perform_async(@user.id, @content, @name, @link)
        end
        if false #disabled, not working with fb share
        @activity = Activity.create!(:user_id => @photo.creator.id, :activity_type => Activity::UPLOAD_PHOTO, :target_type => @photo.class.name, :target_id => @photo.id)
        end
        format.json { render json: [@photo.to_jq_upload].to_json, status: :created, location: user_photo_album_photo_path(@user, @photo_album, @photo) }
#        format.json { render json: {files: [@photo.to_jq_upload]}, status: :created, location: user_photo_album_photo_path(@user, @photo_album, @photo) }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        @photo_album = @user.photo_albums.find_by_id(params[:photo_album_id])
        if !@photo_album.nil?
          @photo = @photo_album.photos.find_by_id(params[:id])
          if !@photo.nil?
            @photo.photoable_id = params[:photoable_id] if params[:photoable_id]
            @photo.photoable_type = params[:photoable_type] if params[:photoable_type]

            @photo.photo_album_id = params[:photo][:photo_album_id] if params[:photo][:photo_album_id]
            @photo.description = params[:photo][:description] if params[:photo][:description]
            @photo.creator_id = @photo_album.creator_id
            # get the new photo_album_id
            @photo_album = @photo.photo_album_id
          else
            flash[:notice] = t(:photo_not_found)
            return redirect_to user_photo_album_path(@user, @photo_album)
          end
        else
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
      else
        flash[:notice] = t(:not_allowed)
        return redirect_back_or_default()
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      if @photo.save
        format.html { redirect_to user_photo_album_photo_path(@user, @photo_album, @photo), :notice => t(:photo_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        @photo_album = @user.photo_albums.find_by_id(params[:photo_album_id])
        if !@photo_album.nil?
          @photo = @photo_album.photos.find_by_id(params[:id])
          if !@photo.nil?
            @photo.destroy
          else
            flash[:notice] = t(:photo_not_found)
            return redirect_to user_photo_album_path(@user, @photo_album)
          end
        else
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
      else
        flash[:notice] = t(:not_allowed)
        return redirect_back_or_default()
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html { redirect_to user_photo_album_url(@user, @photo_album) }
      format.json { head :no_content }
    end
  end

#  def create_profile_photo
#
#  end

  def set_as_profile
    if request.post?
      # get the owner of the photo
      @user = User.find_by_id(params[:user_id])
      if !@user.nil?
        if @user == current_user
          @photo = @user.photos.find_by_id(params[:id])
          if !@photo.nil?
            if @user.profile_photo != @photo
              @user.profile_photo = @photo
              if @user.save
                flash[:notice] = t(:photo_updated)
                redirect_back_or_default
              else
                flash[:notice] = t(:set_profile_fail)
                redirect_back_or_default
              end
            end
          else
            flash[:notice] = t(:photo_not_found)
            redirect_back_or_default
          end
        else
          flash[:notice] = t(:not_allowed)
          redirect_back_or_default
        end
      else
        flash[:notice] = t(:user_not_found)
        redirect_back_or_default
      end
    end

  end
  
  private
  
  def get_exif_info(photo)
    if photo.image_content_type == Photo::JPEG_IMAGE or photo.image_content_type == Photo::JPG_IMAGE
      exif = EXIFR::JPEG.new(photo.image.path(:original))
      return exif
    else
      return nil
    end
  end
end
