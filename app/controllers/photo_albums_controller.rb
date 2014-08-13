class PhotoAlbumsController < ApplicationController
  before_filter :authenticate_user!

  autocomplete :photo_album, :name, :extra_data => [:id]

  def get_autocomplete_items(parameters)
    items = super(parameters)
    items = items.where(:creator_id => current_user.id)
  end
  
  # GET /photo_albums
  # GET /photo_albums.json
  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @photo_albums = get_albums(@user)
      @result_list = @photo_albums.map do |u|
        image = view_context.get_small_photo_url(u.default_photo)
        {
          :latitude => !u.albumable.nil? ? u.albumable.latitude : 0,
          :longitude => !u.albumable.nil? ? u.albumable.longitude : 0,
          :id => u.id,
          :name => u.name,
          :desc => u.description,
#          :region => !u.region.nil? ? u.region.name : "",
#          :country => !u.country.nil? ? u.country.name : "",
          :image => image,
          :path => user_photo_album_url(u.creator, u),
          :type => !u.albumable.nil? ? "Location" : ""
#          :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
#          :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
#          :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : ""
        }
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photo_albums }
    end
  end

  # GET /photo_albums/1
  # GET /photo_albums/1.json
  def show
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @photo_album = @user.photo_albums.find_by_id(params[:id])
      if @photo_album.nil?
        flash[:notice] = t(:photo_album_not_found)
        return redirect_to user_photo_albums_path(@user)
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end

    if (is_user_allowed(@user, @photo_album.privacy))
      @photos = @photo_album.photos.page(params[:photo_album_page]).per(20)
    else
      flash[:notice] = t(:not_allowed)
      return redirect_to user_photo_albums_path(@user)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo_album }
      format.js
    end
  end

  # GET /photo_albums/new
  # GET /photo_albums/new.json
  def new
    @user = User.find_by_id(params[:user_id])
    if @user.nil?
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    else
      if @user == current_user
        # only logged in user can create new album
        @photo_album = @user.photo_albums.new
        @photo = @photo_album.photos.new
      else
        flash[:notice] = t(:not_allowed)
        return redirect_to user_photo_albums_path(@user)
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo_album }
    end
  end

  # GET /photo_albums/1/edit
  def edit
    @user = User.find_by_id(params[:user_id])
    if @user.nil?
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    else
      if @user == current_user
        # current_user is the owner, allow
        @photo_album = @user.photo_albums.find_by_id(params[:id])
        if @photo_album.nil?
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
        if @photo_album.default == true
          flash[:notice] = t(:not_allowed)
          return redirect_to user_photo_albums_path(@user)
        end
      else
        flash[:notice] = t(:not_allowed)
        return redirect_to user_photo_albums_path(@user)
      end
    end
    
  end

  # POST /photo_albums
  # POST /photo_albums.json
  def create
    @user = User.find_by_id(params[:user_id])
    if @user.nil?
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    else
      if @user == current_user
        # only logged in user can create new album
        @photo_album = current_user.photo_albums.find_by_name(params[:photo_album_name])
        if @photo_album.nil?
          @photo_album = current_user.photo_albums.new()
          @photo_album.name = params[:photo_album_name]
          @photo_album.description = params[:photo_album_desc] if params[:photo_album_desc]
          @photo_album.default = false
          @photo_album.privacy = params[:photo_album_priv]
          @photo_album.albumable_id = params[:photo_album_albumable_id] if params[:photo_album_albumable_id]
          @photo_album.albumable_type = params[:photo_album_albumable_type] if params[:photo_album_albumable_type]
          @photo_album.save!
        end
        if params[:photo]
          @photo = @photo_album.photos.new(params[:photo])
          @photo.description = params[:description] if params[:description]
          @photo.photoable_id = @photo_album.albumable_id
          @photo.photoable_type = @photo_album.albumable_type
#          if !@photo_album.albumable.nil?
#            @photo.photoable_id = @photo_album.albumable_id
#            @photo.photoable_type = @photo_album.albumable_type
#          else
#            @photo.photoable_id = params[:photoable_id] if params[:photoable_id]
#            @photo.photoable_type = params[:photoable_type] if params[:photoable_type]
#          end
          @photo.creator_id = @photo_album.creator_id
#          @photoable = params[:photoable_id] if params[:photoable_id]
        end

      else
        flash[:notice] = t(:not_allowed)
        return redirect_to user_photo_albums_path(@user)
      end
    end

    respond_to do |format|
#      if @photo_album.save
#        format.html { redirect_to user_photo_album_path(@user, @photo_album), :notice => t(:photo_album_created) }
#        format.json { render json: @photo_album, status: :created, location: @photo_album }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
#      end
      if @photo.save
        format.html {
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@photo.to_jq_upload].to_json, status: :created, location: user_photo_album_photo_path(@user, @photo_album, @photo) }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photo_albums/1
  # PUT /photo_albums/1.json
  def update
    @user = User.find_by_id(params[:user_id])
    params[:photo_album].delete :default
    if @user.nil?
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    else
      if @user == current_user
        # current_user is the owner, allow
        @photo_album = current_user.photo_albums.find_by_id(params[:id])
        if @photo_album.nil?
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
        if @photo_album.default == true
          flash[:notice] = t(:not_allowed)
          return redirect_to user_photo_albums_path(@user)
        end
        @photo_album.albumable_id = params[:albumable_id] if params[:albumable_id]
        @photo_album.albumable_type = params[:albumable_type] if params[:albumable_type]
      else
        flash[:notice] = t(:not_allowed)
        return redirect_to user_photo_albums_path(@user)
      end
    end

    respond_to do |format|
      if @photo_album.update_attributes(params[:photo_album])
        format.html { redirect_to user_photo_album_path(@user, @photo_album), :notice => t(:photo_album_updated) }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /photo_albums/1
  # DELETE /photo_albums/1.json
  def destroy
    # get the owner of the album
    @user = User.find_by_id(params[:user_id])
    if @user.nil?
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    else
      if @user == current_user
        # current_user is the owner, allow
        @photo_album = current_user.photo_albums.find_by_id(params[:id])
        if @photo_album.nil?
          flash[:notice] = t(:photo_album_not_found)
          return redirect_to user_photo_albums_path(@user)
        end
        if @photo_album.default == true
          flash[:notice] = t(:not_allowed)
          return redirect_to user_photo_albums_path(@user)
        end
        @photo_album.destroy
      else
        flash[:notice] = t(:not_allowed)
        return redirect_to user_photo_albums_path(@user)
      end
    end

    respond_to do |format|
      format.html { redirect_to user_photo_albums_url(@user) }
      format.json { head :no_content }
    end
  end

  private

  def get_albums(user)
    if (user == current_user)
      return @user.photo_albums
    elsif (Friendship.is_friend?(current_user, user))
      return @user.photo_albums.shared_photo_album.includes(:default_photo)
    else
      return @user.photo_albums.public_photo_album.includes(:default_photo)
    end
  end


end
