class CitiesController < ApplicationController
  include CategoriesHelper

#  before_filter :authenticate_user!, :except => [:show, :autocomplete_city_name]
  before_filter :authenticate_user_from_token!, :authenticate_user!, :except => [:show, :autocomplete_city_name]


  def autocomplete_city_name
    search = City.solr_search(:include => [:country, :region]) do
      fulltext params[:term]
    end
    cities = search.results

    data = []
    cities.each do |p|
      if !p.region.nil?
        data << {:label => "#{p.name} - #{p.region.name}, #{p.country.name}", :value => "#{p.name} - #{p.region.name}, #{p.country.name}", :id => "#{p.id}", :latitude => "#{p.latitude}", :longitude => "#{p.longitude}" }
      else
        data << {:label => "#{p.name} - #{p.country.name}", :value => "#{p.name} - #{p.country.name}", :id => "#{p.id}", :latitude => "#{p.latitude}", :longitude => "#{p.longitude}" }
      end
    end
    respond_to do |format|
      format.json { render json: data }
    end
  end

  # GET /cities
  # GET /cities.json
  def index
    if params[:country]
      country = Country.find_by_id(params[:country])
      if !country.nil?
        @cities = country.cities
      else
        flash[:error] = t(:country_not_found)
        @cities = nil
      end
    else
      return redirect_to countries_path
    end

    respond_to do |format|
#      format.html # index.html.erb
      format.json { render json: @cities }
    end
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @city = City.find_by_id(params[:id])

    if !@city.nil?
      # find major categories
      main_categories = Category.where("parent_id is ?", nil).all

#      accomodation = Category.find_by_id(Category::ACCOMODATION)
#      shopping = Category.find_by_id(Category::SHOPPING)
#      sightseeing = Category.find_by_id(Category::SIGHTSEEING)
#      eating = Category.find_by_id(Category::EATING)
#      sport = Category.find_by_id(Category::SPORT)
#      other = Category.find_by_id(Category::OTHER)
#      health = Category.find_by_id(Category::HEALTH)
#      bank = Category.find_by_id(Category::BANK)

      type = params[:type]
      if (type == "accomodation")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[0].children).page(params[:place_page]).per(12)
      elsif (type == "shopping")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[1].children).page(params[:place_page]).per(12)
      elsif (type == "sightseeing")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[2].children).page(params[:place_page]).per(12)
      elsif (type == "eating")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[3].children).page(params[:place_page]).per(12)
      elsif (type == "sport")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[4].children).page(params[:place_page]).per(12)
      elsif (type == "health")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[6].children).page(params[:place_page]).per(12)
      elsif (type == "bank")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[7].children).page(params[:place_page]).per(12)
      elsif (type == "other")
        @places = @city.places.includes(:city, :reviews, :default_photo).where(category_id: main_categories[5].children).page(params[:place_page]).per(12)
#      elsif (type == "popular")
#        @places = @city.places.popular.includes(:city, :category, :reviews, :default_photo).page(params[:place_page]).per(12)
      else # default popular
        @places = @city.places.popular.includes(:city, :category, :reviews, :default_photo).page(params[:place_page]).per(12)
      end

      sort = params[:sort]
      if (sort == "popular")
        @reviews = @city.reviews.by_votes.includes({:creator => [:profile, :profile_photo]}, :review_photos, :review_votes).page(params[:review_page]).per(5)
      elsif (sort == "friends")
        @reviews = current_user.friends_reviews.includes({:creator => [:profile, :profile_photo]}, :review_photos, :review_votes).order("updated_at DESC").where("reviewable_type = ? and reviewable_id = ?", @city.class.to_s, @city.id).page(params[:review_page]).per(5)
      elsif (sort == "myself")
        @reviews = current_user.reviews.includes({:creator => [:profile, :profile_photo]}, :review_photos, :review_votes).order("updated_at DESC").where("reviewable_type = ? and reviewable_id = ?", @city.class.to_s, @city.id).page(params[:review_page]).per(5)
      else # default recent
        @reviews = @city.reviews.includes({:creator => [:profile, :profile_photo]}, :review_photos, :review_votes).order("updated_at DESC").page(params[:review_page]).per(5)
      end

      if (@city.photos.public_photo.count > 0)
        @city_cover_photo = @city.photos.public_photo.last
      else
        @city_cover_photo = nil
      end

      @review = Review.new
      @reviewable = @city

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
          :category => get_category_icon(u.category)
        }
      end

      @liked = @city.liked_users.includes(:profile, :profile_photo).page(params[:friend_page]).per(10)
      @visitors = @city.visited_cities.includes(:user => [:profile, :profile_photo]).order("updated_at DESC").page(params[:visited_page]).per(10)

#      @activities = Activity.includes(:target, :user).page(params[:page]).per(10)
#      polymorphic_association_includes @activities, :target, {
#        Photo => [:photoable, :creator, :photo_album],
#        Review => [:creator, :review_photos, :reviewable],
#        Event => [{:creator => :profile_photo}, :place]
#      }
      if !current_user.nil?
        @event = current_user.events.new
        @user = current_user
      end
    else
      flash[:error] = t(:city_not_found)
      return redirect_back_or_default(countries_path)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city }
      format.js
    end
  end

  def get_places
    lat = params["lat"]
    lng = params["lng"]
    city = City.near([lat, lng], 5).order("distance").first

    result = Hash.new
    if !city.nil?
      places = city.places.near([lat, lng], 2).order("distance").limit(10);
      result[:places] = places
    else
      result[:places] = []
    end
    respond_to do |format|
      format.json { render json: result }
    end
  end

  # GET /cities/new
  # GET /cities/new.json
  def new
    @country = Country.find_by_id(params[:country])
    if !@country.nil?
      @city = City.new

    else
      flash[:error] = "Country not found"
      redirect_to countries_path
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @city }
    end
  end

  # GET /cities/1/edit
  def edit
    @city = City.find_by_id(params[:id])
    if !@city.nil?
      @country = @city.country
    else
      flash[:error] = t(:city_not_found)
      return redirect_back_or_default()
    end
  end

  # POST /cities
  # POST /cities.json
  def create
    @country = Country.find_by_id(params[:city][:country_id])
    if !@country.nil?
      @region = @country.regions.find_by_id(params[:city][:region_id])
      if !@region.nil?
        @city = City.new(params[:city])
      else
        flash[:notice] = "Region not found"
        return redirect_to country_path(@country)
      end
    else
      flash[:notice] = "Country not found"
      return redirect_to countries_path
    end


    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render json: @city, status: :created, location: @city }
      else
        format.html { render action: "new" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cities/1
  # PUT /cities/1.json
  def update
    @city = City.find_by_id(params[:id])

    respond_to do |format|
      if @city.update_attributes(params[:city])
        format.html { redirect_to @city, notice: t(:city_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_in
    if params[:city_id]
      @user = User.find_by_id(current_user)
      if !@user.nil?
        @city = City.find_by_id(params[:city_id])
        if !@city.nil?
          @visited_city = VisitedCity.find_by_user_id_and_city_id(@user.id, @city.id)
          if !@visited_city.nil?
            # update updated_at
            @visited_city.save!
            flash[:notice] = t(:checkin_succeed, :username => @user.profile.full_name, :placename => @city.name)
          else
            @visited_city = current_user.visited_cities.new
            @visited_city.city_id = @city.id
            if @visited_city.save
              @city = City.find_by_id(params[:city_id])
              flash[:notice] = t(:checkin_succeed, :username => @user.profile.full_name, :placename => @city.name)
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
    @city = City.find_by_id(params[:city_id])
    if !@city.nil?
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
end
