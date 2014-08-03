class FavoriteCitiesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /favorite_cities
  # GET /favorite_cities.json
  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @cities = @user.my_favorite_cities.includes(:region, :country).order("updated_at DESC").page(params[:page]).per(25)
#      @cities.to_json(:include => [:region, :country])

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
