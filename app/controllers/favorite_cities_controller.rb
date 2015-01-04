class FavoriteCitiesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /favorite_cities
  # GET /favorite_cities.json
  def index
    @user = User.find_by_id(params[:user_id])
    @location = nil
    @hometown = nil
    if request.xhr?
      puts "respond to Ajax request"
      a = params[:b1].to_f
      b = params[:b2].to_f
      c = params[:b3].to_f
      d = params[:b4].to_f
      @zoom = 0
    else
      puts "respond to normal request"
      @location = @user.location
      @hometown = @user.hometown
      if !@location.nil?
        puts "respond from location"
        a = @location.latitude - 0.01
        b = @location.longitude - 0.01
        c = @location.latitude + 0.01
        d = @location.longitude + 0.01
        @zoom = 0
      elsif !@hometown.nil?
        puts "respond from hometown"
        a = @hometown.latitude - 0.01
        b = @hometown.longitude - 0.01
        c = @hometown.latitude + 0.01
        d = @hometown.longitude + 0.01
        @zoom = 0
      else
        a = params[:b1].to_f
        b = params[:b2].to_f
        c = params[:b3].to_f
        d = params[:b4].to_f
        @zoom = 0
      end
    end
    
    puts a
    puts b
    puts c
    puts d
    
    if !@user.nil?
      @cities = @user.my_favorite_cities.where("latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?", params[:b1], params[:b3], params[:b2], params[:b4]).includes(:region, :country, :default_city_photo).order("updated_at DESC").page(params[:page]).per(25)
#      @cities.to_json(:include => [:region, :country])

      @cities_list = @cities.map do |u|
        image = view_context.get_small_photo_url(u.default_city_photo)
        {
          :latitude => u.latitude,
          :longitude => u.longitude,
          :id => u.id,
          :name => u.name,
          :region => !u.region.nil? ? u.region.name : "",
          :country => !u.country.nil? ? u.country.name : "",
          :image => image,
          :path => city_url(u),
          :rate => u.favorite_cities_count
        }
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cities_list }
      format.js
    end
  end

  # POST /favorite_cities
  # POST /favorite_cities.json
  def create
    @user = User.find_by_id(params[:favorite_city][:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @city = City.find_by_id(params[:favorite_city][:city_id])
        if !@city.nil?
          @favorite_city = @user.favorite_cities.create(:city_id => @city.id)
          @city = City.find_by_id(params[:favorite_city][:city_id])
          flash[:notice] = t(:like_succeed, :username => @user.profile.full_name, :placename => @city.name)
        else
          flash[:notice] = t(:request_fail)
        end
      else
        flash[:notice] = t(:not_allowed)
      end
    else
      flash[:notice] = t(:user_not_found)
    end
    render :toggle
  end

  # DELETE /favorite_cities/1
  # DELETE /favorite_cities/1.json
  def destroy
    @user = User.find_by_id(params[:favorite_city][:user_id])
    if !@user.nil?
      if (is_current_user(@user))
        @favorite_city = @user.favorite_cities.find_by_id(params[:id])
        if !@favorite_city.nil?
          @city = @favorite_city.city
          temp_city_id = @city.id
          @favorite_city.destroy
          @city = City.find_by_id(temp_city_id)
          flash[:notice] = t(:unlike_succeed, :username => @user.profile.full_name, :placename => @city.name)
        else
          flash[:notice] = t(:request_fail)
        end
      else
        flash[:notice] = t(:not_allowed)
      end
    else
      flash[:notice] = t(:user_not_found)
    end
    render :toggle
  end
end
