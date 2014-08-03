class VisitedCitiesController < ApplicationController
  before_filter :authenticate_user!

  # GET /visited_cities
  # GET /visited_cities.json
  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @cities = @user.my_visited_cities.includes(:country, :region).order("updated_at DESC").page(params[:page]).per(25)
#      @places.to_json(:include => :city)

      @cities_list = @cities.map do |u|
        image = view_context.place_small_photo(u)
        {
          :latitude => u.latitude,
          :longitude => u.longitude,
          :id => u.id,
          :name => u.name,
          :region => !u.region.nil? ? u.region.name : "",
          :country => !u.country.nil? ? u.country.name : "",
          :image => image,
          :path => city_url(u)
        }
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html # index.html.erb
#      format.json { render json: @places_list }
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
