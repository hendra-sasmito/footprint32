class VisitedPlacesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @places = @user.my_visited_places.includes(:default_place_photo, :category, :city => [:country, :region]).order("updated_at DESC").page(params[:page]).per(25)
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
    @user = User.find_by_id(params[:visited_place][:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @place = Place.find_by_id(params[:visited_place][:place_id])
        if !@place.nil?
          @visited_place = @user.visited_places.create(:place_id => @place.id)
          @place = Place.find_by_id(params[:visited_place][:place_id])
          flash[:notice] = t(:checkin_succeed, :username => @user.profile.full_name, :placename => @place.name)
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
    @user = User.find_by_id(params[:visited_place][:user_id])
    if !@user.nil?
      if (is_current_user(@user))
        @visited_place = @user.visited_places.find_by_id(params[:id])
        if !@visited_place.nil?
          @place = @visited_place.place
          temp_place_id = @place.id
          @visited_place.destroy
          @place = Place.find_by_id(temp_place_id)
          flash[:notice] = t(:undo_checkin_succeed, :username => @user.profile.full_name, :placename => @place.name)
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
