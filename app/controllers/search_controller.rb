class SearchController < ApplicationController
  include PlacesHelper
  before_filter :authenticate_user!

  def autocomplete_place_city_name
    search = Sunspot.search Place, City do
#      City.solr_search(:include => [:country, :region]) do
      fulltext params[:term]
#      instance_adapter_for(Place).include(:city => [:region, :country])
#      instance_adapter_for(City).include(:region, :country)
      data_accessor_for(Place).include = [:city => [:region, :country]]
      data_accessor_for(City).include = [:region, :country]
    end
    result = search.results
    puts "----"
    puts result.size

    data = []
    result.each do |p|
      if !p.nil?
        if p.class.to_s == "City"
          data << {:label => "#{p.name} - #{p.country.name}",
          :value => "#{p.name} - #{p.country.name}",
          :id => "#{p.id}",
          :name => "#{p.name}",
          :image => "#{place_thumb_photo(p)}",
          :latitude => "#{p.latitude}",
          :longitude => "#{p.longitude}",
          :type => "City" }
        elsif p.class.to_s == "Place"
          data << {:label => "#{p.name} : #{p.street} #{p.city.name}, #{p.country.name}",
          :value => "#{p.name} : #{p.street} #{p.city.name}, #{p.country.name}",
          :id => "#{p.id}",
          :name => "#{p.name}",
          :address => "#{p.street} #{p.city.name}, #{p.country.name}",
          :category => "#{p.category.name}",
          :description => "#{p.description}",
          :image => "#{place_thumb_photo(p)}",
          :type => "Place"
        }
        end

        #data << {:label => "#{p.name} - #{p.city.name}, #{p.city.region.name} - #{p.city.country.name}", :value => "#{p.name} - #{p.city.name}, #{p.city.region.name} - #{p.city.country.name}", :id => "#{p.id}", :latitude => "#{p.latitude}", :longitude => "#{p.longitude}", :type => "Place" }
      end
#      if !p.region.nil?
#        data << {:label => "#{p.name} - #{p.region.name}, #{p.country.name}", :value => "#{p.name} - #{p.region.name}, #{p.country.name}", :id => "#{p.id}", :latitude => "#{p.latitude}", :longitude => "#{p.longitude}" }
#      else
#        data << {:label => "#{p.name} - #{p.country.name}", :value => "#{p.name} - #{p.country.name}", :id => "#{p.id}", :latitude => "#{p.latitude}", :longitude => "#{p.longitude}" }
#      end
    end
    respond_to do |format|
      format.json { render json: data }
    end
  end

  def index
    keyword = params[:search]
    term = params[:option]

    @keyword = keyword
    @term = term
    
    if keyword.blank?
      flash[:notice] = t(:keyword_empty)
      return
    end

    @users = nil
    @places = nil
    if @term == "people"
#      @users = User.joins(:profile).where("profiles.first_name LIKE ? or email LIKE ?", "%"+keyword+"%", "%"+keyword+"%").order("profiles.first_name").includes(:profile, :location, {:profile_photo => :photo}).without_user(current_user).uniq.page(params[:people_page]).per(2)
      search = User.solr_search(:include => [:profile, :profile_photo]) do
        fulltext params[:search]
        paginate :page => params[:people_page], :per_page => 10
      end
      @users = search.results

    elsif term == "place"
#      @places = Place.where("name LIKE ? or street LIKE ? or city LIKE ? or country LIKE ?", "%"+keyword+"%", "%"+keyword+"%", "%"+keyword+"%", "%"+keyword+"%").order("name").uniq.page(params[:place_page]).per(2)
      search_place = Place.solr_search(:include => [:category, :city => [:country, :region]]) do
        fulltext params[:search] #, :minimum_match => 1
        paginate :page => params[:place_page], :per_page => 12
      end
      @places = search_place.results

      search_city = City.solr_search(:include => [:country, :region]) do
        fulltext params[:search] #, :minimum_match => 1
        paginate :page => params[:city_page], :per_page => 6
      end
      @cities = search_city.results
    end

    puts @places
    puts @cities

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
  
end
