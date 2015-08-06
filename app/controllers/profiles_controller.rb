class ProfilesController < ApplicationController
  before_filter :authenticate_user_from_token!, :authenticate_user!

  helper :friendship
  
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @profile = @user.profile
      @photo_album = current_user.photo_albums.find_by_default(true)
      @photo = @photo_album.photos.new
#      @requested_friends_count = @user.requested_friends.count
#      @pending_friends_count = @user.pending_friends.count

      @favorite_places = @user.favorite_places.order('updated_at DESC').includes(:place => [{:city => [:country, :region]}, :category]).limit(9)

      @visited_places = @user.visited_places.order('updated_at DESC').includes(:place => [{:city => [:country, :region]}, :category]).limit(9)

      @favorite_cities = @user.favorite_cities.order('updated_at DESC').includes(:city => [:country, :region]).limit(9)

      @visited_cities = @user.visited_cities.order('updated_at DESC').includes(:city => [:country, :region]).limit(9)

#      @friends = @user.friends.includes(:profile).limit(10)

#      if (@user == current_user) or (Friendship.find_by_user_id_and_friend_id(current_user, @user) == "accepted")
#        @events = @user.events.includes(:creator, :place).incoming_event
#      else
#        @events = @user.events.includes(:creator, :place).public_event.incoming_event
#      end
      if is_current_user(@user)
        @photos = @user.photos.includes(:creator, :photo_album).order('photos.updated_at DESC').page(params[:photo_page]).per(12)
      else
        @photos = @user.photos.public_photo.includes(:creator, :photo_album).order('photos.updated_at DESC').page(params[:photo_page]).per(12)
      end
#      @activities = Activity.includes(:target, :user).page(params[:page]).per(10)
      #@events = @user.events.includes(:creator, :place).incoming_event

      @reviews = @user.reviews.includes(:reviewable, :review_photos, :creator => [:profile, :profile_photo]).order('updated_at DESC').page(params[:review_page]).per(10)
      @comment = Comment.new
      #@location = @user.location

      #json
      result = Hash.new
      result[:profile] = @profile
      result[:favorite_places] = @user.favorite_places.size
      result[:visited_places] = @user.visited_places.size
      result[:favorite_cities] = @user.favorite_cities.size
      result[:visited_cities] = @user.visited_cities.size
      result[:email] = @user.email

#      @activities = Activity.includes(:target, :user).page(params[:page]).per(10)
#      @activities = Activity.includes(:target, :user).page(params[:page]).per(10)
#      polymorphic_association_includes @activities, :target, {
#        Photo => [:photoable, :creator, :photo_album],
#        Review => [:creator, :review_photos, :reviewable],
#        Event => [{:creator => :profile_photo}, :place]
#      }

#      @my_activities = @user.activities.includes(:target, :user).page(params[:page]).per(10)
#      polymorphic_association_includes @activities, :target, {
#        Photo => [:photoable, :creator, :photo_album],
#        Review => [:creator, :review_photos, :reviewable],
#        Event => [{:creator => :profile_photo}, :place]
#      }
      
    else
      flash[:notice] = t(:user_not_found)
      return redirect_to home_index_path
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: result }
      format.js
    end
  end

  # GET /profiles/1/edit
  def edit
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        @profile = current_user.profile
        @photo_album = current_user.photo_albums.find_by_default(true)
        @photo = @photo_album.photos.new
      else
        flash[:notice] = t(:not_allowed)
        redirect_to user_profile_path(current_user)
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if @user == current_user
        @profile = current_user.profile
      else
        flash[:notice] = t(:not_allowed)
        redirect_to user_profile_path(current_user)
      end
    else
      flash[:notice] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to user_profile_path(current_user), :notice => t(:profile_updated) }
        format.json { render :json => { :success => true,
                      :info => "Profile updated" } }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

end
