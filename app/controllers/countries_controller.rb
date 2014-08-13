class CountriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  
  autocomplete :country, :name, :extra_data => [:id]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.find_by_id(params[:id])
    if !@country.nil?

      if params[:filter]
        if params[:filter] == "all"
          @cities = @country.cities.includes(:region, :country, :default_city_photo).order("places_count DESC").page(params[:page]).per(12)
        else
          @cities = @country.cities.includes(:region, :country, :default_city_photo).where("name LIKE :prefix", prefix: "#{params[:filter]}%").order("places_count DESC").page(params[:page]).per(12)
        end
      else
        @cities = @country.cities.includes(:region, :country, :default_city_photo).order("places_count DESC").page(params[:page]).per(12)
      end
    else
      flash[:notice] = t(:country_not_found)
      return redirect_back_or_default(countries_path)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
      format.js
    end
  end

end
