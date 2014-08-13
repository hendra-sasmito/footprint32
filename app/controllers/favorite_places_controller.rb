class FavoritePlacesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @places = @user.my_favorite_places.includes(:default_place_photo, :category, :city => [:region, :country]).order("updated_at DESC").page(params[:page]).per(25)
#      @places.to_json(:include => :city)

      @places_list = @places.map do |u|
        image = view_context.get_small_photo_url(u.default_place_photo)
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
          :path => place_url(u)
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
    @user = User.find_by_id(params[:favorite_place][:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @place = Place.find_by_id(params[:favorite_place][:place_id])
        if !@place.nil?
          @favorite_place = @user.favorite_places.create(:place_id => @place.id)
          @place = Place.find_by_id(params[:favorite_place][:place_id])
          flash[:notice] = t(:like_succeed, :username => @user.profile.full_name, :placename => @place.name)
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
    @user = User.find_by_id(params[:favorite_place][:user_id])
    if !@user.nil?
      if (is_current_user(@user))
        @favorite_place = @user.favorite_places.find_by_id(params[:id])
        if !@favorite_place.nil?
          @place = @favorite_place.place
          temp_place_id = @place.id
          @favorite_place.destroy
          @place = Place.find_by_id(temp_place_id)
          flash[:notice] = t(:unlike_succeed, :username => @user.profile.full_name, :placename => @place.name)
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
