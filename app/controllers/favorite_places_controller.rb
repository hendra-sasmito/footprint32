class FavoritePlacesController < ApplicationController
  before_filter :authenticate_user_from_token!, :authenticate_user!

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
      @places = @user.my_favorite_places.where("latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?", params[:b1], params[:b3], params[:b2], params[:b4]).includes(:default_photo, :category, :city => [:region, :country]).page(params[:page]).per(50)
#      @places.to_json(:include => :city)

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
          :rate => u.favorite_places_count
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
    @user = User.find_by_id(params[:favorite_place][:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @place = Place.find_by_id(params[:favorite_place][:place_id])
        if !@place.nil?
          @favorite_place = @user.favorite_places.find_by_place_id(@place.id)
          if @favorite_place.nil?
            @favorite_place = @user.favorite_places.create(:place_id => @place.id)
          end
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
    
    respond_to do |format|
      if !@favorite_place.valid?
        format.js { render :toggle }
        format.json { render :json => { :success => false,
                    :info => "Error" } }
      else
        format.js { render :toggle }
        format.json { render :json => { :success => true,
                    :info => "Liked", :dislike => @favorite_place.id } }
      end
    end
  end

  def destroy
    success = 0
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
          success = 1
        else
          flash[:notice] = t(:request_fail)
        end
      else
        flash[:notice] = t(:not_allowed)
      end
    else
      flash[:notice] = t(:user_not_found)
    end
    respond_to do |format|
      if success == 0
        format.js { render :toggle }
        format.json { render :json => { :success => false,
                    :info => "Error" } }
      else
        format.js { render :toggle }
        format.json { render :json => { :success => true,
                    :info => "Disliked", :dislike => 0 } }
      end
    end
  end

end
