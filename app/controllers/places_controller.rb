class PlacesController < ApplicationController
  include PlacesHelper

  before_filter :authenticate_user!, :except => [:show]
#  autocomplete :place, :name, :extra_data => [:id]

  def autocomplete_place_name
    search = Place.solr_search(:include => [:city => [:region, :country]]) do
      fulltext params[:term]
    end
    places = search.results
    data = []
    places.each do |p|
      data << {:label => "#{p.name} : #{p.street} #{p.city.name}, #{p.country.name}",
        :value => "#{p.name} : #{p.street} #{p.city.name}, #{p.country.name}",
        :id => "#{p.id}",
        :name => "#{p.name}",
        :address => "#{p.street} #{p.city.name}, #{p.country.name}",
        :category => "#{p.category.name}",
        :description => "#{p.description}",
        :image => "#{place_thumb_photo(p)}" }
    end
    respond_to do |format|
      format.json { render json: data }
    end
  end

  # GET /places
  # GET /places.json
  def index
    #@places = nil #Place.all
    latitude = 47.7818;
    longitude = 9.61294;
    @places = Place.includes(:city, :reviews, :default_photo).near([latitude, longitude], Footprint32::NEARBY_PLACE_DISTANCE)
    @places_list = @places.map do |u|
      image = view_context.get_small_photo_url(u.default_photo)
      {
        :latitude => u.latitude,
        :longitude => u.longitude,
        :id => u.id,
        :name => u.name,
        :desc => !u.description.nil? ? u.description : "",
        :street => !u.street.nil? ? u.street : "",
        :city => u.city.name,
        :region => !u.city.region.nil? ? u.city.region.name : "",
        :country => !u.city.country.nil? ? u.city.country.name : "",
        :image => image,
        :path => place_url(u),
        :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
        :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
        :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : "",
        :rate => u.favorite_places_count
      }
    end

    @location = request.location #current_user.location

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find_by_id(params[:id])
    if @place.nil?
      flash[:notice] = t(:place_not_found)
      return redirect_to places_path
    else
      sort = params[:sort]
      if (sort == "popular")
        @reviews = @place.reviews.by_votes.includes({:creator => [:profile, :profile_photo]}, :review_photos).page(params[:review_page]).per(5)
      elsif (sort == "friends")
        @reviews = current_user.friends_reviews.includes({:creator => [:profile, :profile_photo]}, :review_photos).order("created_at DESC").where("reviewable_type = ? and reviewable_id = ?", @place.class.to_s, @place.id).page(params[:review_page]).per(5)
      elsif (sort == "myself")
        @reviews = current_user.reviews.includes({:creator => [:profile, :profile_photo]}, :review_photos).order("created_at DESC").where("reviewable_type = ? and reviewable_id = ?", @place.class.to_s, @place.id).page(params[:review_page]).per(5)
      else # default recent
        @reviews = @place.reviews.includes({:creator => [:profile, :profile_photo]}, :review_photos).order("created_at DESC").page(params[:review_page]).per(5)
      end

      @place_photos = @place.photos.joins(:photo_album).includes(:photo_album, :creator => [:profile, :profile_photo]).where("privacy = ?", Footprint32::PUBLIC).page(params[:place_photo_page]).per(5)

#      if user_signed_in?
#        @friends = @place.liked_users.where(id: current_user.friend_ids).includes(:profile).page(params[:friend_page]).per(5)
#
#        @visited = @place.visited_places.where(user_id: current_user.friend_ids).order("updated_at DESC").page(params[:visited_page]).per(5)
#      end

      if (@place.photos.public_photo.count > 0)
        @place_cover_photo = @place.photos.public_photo.last
      else
        @place_cover_photo = nil
      end
  
      @liked = @place.liked_users.includes(:profile, :profile_photo).page(params[:friend_page]).per(10)
      @visitors = @place.visited_places.includes(:user => [:profile, :profile_photo]).order("updated_at DESC").page(params[:visited_page]).per(10)

#      @events = @place.events.public_event.incoming_event.includes({:creator => [:profile]}).order("date ASC").page(params[:event_page]).per(5)

      @comment = Comment.new
      @review = Review.new
      #1.times { @review.review_photos.build }
      @reviewable = @place
      @nearby_places = Place.includes({:city => [:country, :region]}, :category, :default_photo, {:reviews => {:creator => :profile}}).where("id != ?", @place.id).near([@place.latitude, @place.longitude], Footprint32::NEARBY_PLACE_DISTANCE).limit(5)
      @places_list = @nearby_places.map do |u|
        image = view_context.get_small_photo_url(u.default_photo)
        {
          :latitude => u.latitude,
          :longitude => u.longitude,
          :id => u.id,
          :name => u.name,
          :desc => !u.description.nil? ? u.description : "",
          :street => !u.street.nil? ? u.street : "",
          :city => u.city.name,
          :region => !u.city.region.nil? ? u.city.region.name : "",
          :country => !u.city.country.nil? ? u.city.country.name : "",
          :image => image,
          :path => place_url(u),
          :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
          :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
          :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : "",
          :rate => u.favorite_places_count
        }
      end

#      @activities = Activity.includes(:target, :user).page(params[:page]).per(10)
#      polymorphic_association_includes @activities, :target, {
#        Photo => [:photoable, {:creator => :profile_photo}, :photo_album],
#        Review => [{:creator => :profile_photo}, :review_photos, :reviewable],
#        Event => [{:creator => :profile_photo}, :place]
#      }
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
      format.js
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new
    @location = current_user.location
    if params[:city]
      @city = City.includes(:country, :region).find_by_id(params[:city])
      @place.city = @city
      latitude = @city.latitude
      longitude = @city.longitude
    elsif !@location.nil?
      latitude = @location.latitude
      longitude = @location.longitude
    else
      latitude = 47.7818
      longitude = 9.61294
    end

    @places = Place.includes(:city, :reviews, :default_photo).near([latitude, longitude], Footprint32::NEARBY_PLACE_DISTANCE)
    @places_list = @places.map do |u|
      image = view_context.get_small_photo_url(u.default_photo)
      {
        :latitude => u.latitude,
        :longitude => u.longitude,
        :id => u.id,
        :name => u.name,
        :desc => !u.description.nil? ? u.description : "",
        :street => !u.street.nil? ? u.street : "",
        :city => u.city.name,
        :region => !u.city.region.nil? ? u.city.region.name : "",
        :country => !u.city.country.nil? ? u.city.country.name : "",
        :image => image,
        :path => place_url(u),
        :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
        :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
        :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : "",
        :rate => u.favorite_places_count
      }
    end

    @main_categories, @categories = get_categories


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find_by_id(params[:id])
    if @place.nil?
      flash[:notice] = t(:place_not_found)
      return redirect_to places_path
    else
      @main_categories, @categories = get_categories
    end
  end

  # POST /places
  # POST /places.json
  def create
    @main_categories, @categories = get_categories
    
    @place = Place.new(params[:place])
    @place.category_id = params[:category]
#    if !params[:new_city].blank? and !params[:new_city_name].blank? and !params[:country_id].blank?
#      @country = Country.find_by_id(params[:country_id])
#      if @country.nil?
#        flash[:notice] = t(:country_not_found)
#        return render action: "new"
#      end
#      @city = City.find_by_name_and_country_id(params[:new_city_name], params[:country_id])
#      if @city.nil?
#        @city = City.new
#        @city.name = params[:new_city_name]
#        @city.country_id = params[:country_id]
#        @city.save!
#      end
#      @place.city_id = @city.id
#    else
    
    @city = City.find_by_id(params[:place][:city_id])
    if !@city.nil?
      @place.city_id = @city.id
      existing_place = @city.places.find_by_name(params[:place][:name])
      if !existing_place.nil?
        flash[:notice] = "Place is alredy exist"
        return redirect_to new_place_path
        return render action: "new"
      end
    else
      flash[:notice] = t(:city_blank)
      return redirect_to new_place_path
      return render action: "new"
    end
#    end

    respond_to do |format|
      if @place.save
        format.html { redirect_to(@place, :notice => t(:place_created)) }
        format.json { render json: @place, status: :created, location: @place }
      else
        @main_categories, @categories = get_categories
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find_by_id(params[:id])
    if @place.nil?
      flash[:notice] = t(:place_not_found)
      return redirect_to places_path
    else
      category = @place.category
      @place.assign_attributes(params[:place])
#      if !params[:new_city].blank? and !params[:new_city_name].blank? and !params[:country_id].blank?
#        @country = Country.find_by_id(params[:country_id])
#        if @country.nil?
#          flash[:notice] = t(:country_not_found)
#          return render action: "new"
#        end
#        @city = City.find_by_name_and_country_id(params[:new_city_name], params[:country_id])
#        if @city.nil?
#          @city = City.new
#          @city.name = params[:new_city_name]
#          @city.country_id = params[:country_id]
#          @city.save!
#        end
#        @place.city_id = @city.id
#        @place.country_id = @city.country.id
#      else
      puts "-------------------"
      puts params[:change_category]
      if params[:change_category] == "1"
        puts "change"
        @place.category_id = params[:category]
      else
        puts "blank"
        @place.category_id = category.id
      end






      @city = City.find_by_id(params[:place][:city_id])
      if !@city.nil?
        @place.city_id = @city.id
      else
        flash[:notice] = t(:city_blank)
        return render action: "new"
      end
#      end
    end

    respond_to do |format|
      if @place.save!
        format.html { redirect_to @place, :notice => t(:place_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
#  def destroy
    # only for admin
#    @place = Place.find_by_id(params[:id])
#    if @place.nil?
#      flash[:notice] = t(:place_not_found)
#      return redirect_to places_path
#    else
#      @place.destroy
#    end
#
#    respond_to do |format|
#      format.html { redirect_to places_url }
#      format.json { head :no_content }
#    end
#  end

  def discover
    if (!params[:lat].nil? && !params[:lng].nil?)
      @discover = true
      @places = Place.includes(:city, :reviews, :default_photo).near([params[:lat], params[:lng]], Footprint32::NEARBY_PLACE_DISTANCE)
      @places_list = @places.map do |u|
        image = view_context.get_small_photo_url(u.default_photo)
        {
          :latitude => u.latitude,
          :longitude => u.longitude,
          :id => u.id,
          :name => u.name,
          :desc => !u.description.nil? ? u.description : "",
          :street => !u.street.nil? ? u.street : "",
          :city => u.city.name,
          :region => !u.city.region.nil? ? u.city.region.name : "",
          :country => !u.city.country.nil? ? u.city.country.name : "",
          :image => image,
          :path => place_url(u),
          :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
          :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
          :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : "",
          :rate => u.favorite_places_count
        }
      end
      @ref_lat = params[:lat]
      @ref_long = params[:lng]

      puts "-------------"
      puts @places.length
      # @places.to_json(:include => :city)
    else
      if (!params[:place].nil?)
        @discover = false
        @place_id = params[:place]
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def check_in
    if request.post? and params[:place_id]
      @user = User.find_by_id(current_user)
      if !@user.nil?
        @place = Place.find_by_id(params[:place_id])
        if !@place.nil?
          @user.profile.location_id = @place.id
          @user.save!

          @visited_place = VisitedPlace.find_by_user_id_and_place_id(@user.id, @place.id)
          if !@visited_place.nil?
            # update updated_at
            @visited_place.save!
            flash[:notice] = t(:checkin_succeed, :username => @user.profile.full_name, :placename => @place.name)
          else
            @visited_place = current_user.visited_places.new
            @visited_place.place_id = @place.id
            if @visited_place.save
              @place = Place.find_by_id(params[:place_id])
              flash[:notice] = t(:checkin_succeed, :username => @user.profile.full_name, :placename => @place.name)
            else
              flash[:notice] = t(:request_fail)
            end
          end
        else
          flash[:notice] = t(:place_not_found)
        end
      else
        flash[:notice] = t(:user_not_found)
      end
    else
    end

    respond_to do |format|
      #format.html { redirect_to(request.referer) }
      format.js
    end
    
  end

  def upload_photo
    @place = Place.find_by_id(params[:place_id])
    if !@place.nil?
      @user = current_user
      @photo_album = current_user.photo_albums.find_by_default(true)
      if !@photo_album.nil?
        @photo = @photo_album.photos.new
      else
        flash[:notice] = t(:photo_album_not_found)
        return redirect_back_or_default(user_photo_albums_path(@user))
      end
    else
      flash[:notice] = t(:place_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  private

  def get_categories
    main_categories = Category.where("parent_id is ?", nil)
    categories = Category.find_by_id(1).children
    return main_categories, categories
  end

end
