class VisitedCitiesController < ApplicationController
  before_filter :authenticate_user_from_token!, :authenticate_user!

  # GET /visited_cities
  # GET /visited_cities.json
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
      @cities = @user.my_visited_cities.where("latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?", params[:b1], params[:b3], params[:b2], params[:b4]).includes(:country, :region, :default_photo).page(params[:page]).per(25)
#      @places.to_json(:include => :city)

      @cities_list = @cities.map do |u|
        image = view_context.get_small_photo_url(u.default_photo)
        {
          :latitude => u.latitude,
          :longitude => u.longitude,
          :id => u.id,
          :name => u.name,
          :region => !u.region.nil? ? u.region.name : "",
          :country => !u.country.nil? ? u.country.name : "",
          :image => image,
          :path => city_url(u),
          :rate => u.visited_cities_count
        }
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places_list }
      format.js
    end
  end

  def create
    @user = User.find_by_id(params[:visited_city][:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @city = City.find_by_id(params[:visited_city][:city_id])
        if !@city.nil?
          @visited_city = @user.visited_cities.create(:city_id => @city.id)
          @city = City.find_by_id(params[:visited_city][:city_id])
          flash[:notice] = t(:checkin_succeed, :username => @user.profile.full_name, :placename => @city.name)
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

  def destroy
    @user = User.find_by_id(params[:visited_city][:user_id])
    if !@user.nil?
      if (is_current_user(@user))
        @visited_city = @user.visited_cities.find_by_id(params[:id])
        if !@visited_city.nil?
          @city = @visited_city.city
          temp_city_id = @city.id
          @visited_city.destroy
          @city = City.find_by_id(temp_city_id)
          flash[:notice] = t(:undo_checkin_succeed, :username => @user.profile.full_name, :placename => @city.name)
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
