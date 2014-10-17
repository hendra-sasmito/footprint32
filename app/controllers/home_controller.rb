class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    puts "------------home index----------"
    puts params[:b1]
    puts params[:b2]
    puts params[:b3]
    puts params[:b4]
    puts "------"
    puts params[:option]
    a = params[:b1].to_f
    b = params[:b2].to_f
    c = params[:b3].to_f
    d = params[:b4].to_f
    puts a
    puts b
    puts c
    puts d
    option = params[:option]
    if option == "place"
      @result = Place.where("latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?", params[:b1], params[:b3], params[:b2], params[:b4]).includes({:city => [:country, :region]}, :category, :reviews, :default_place_photo).order("favorite_places_count DESC").page(params[:place_page]).per(50)
      @result_list = @result.map do |u|
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
          :path => place_url(u),
          :type => "Place",
          :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
          :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
          :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : ""
        }
      end
    elsif option == "city"
      @result = City.where("latitude > ? AND latitude < ? AND longitude > ? AND longitude < ?", params[:b1], params[:b3], params[:b2], params[:b4]).includes(:country, :region, :reviews, :default_city_photo).order("favorite_cities_count DESC").page(params[:place_page]).per(50)
      @result_list = @result.map do |u|
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
          :type => "City",
          :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
          :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
          :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : ""
        }
      end
    else
#      activities = Activity.where("activity_type <= ?", 2).includes(:target).order("created_at DESC").page(params[:page]).per(10)
#      puts "----"
#      @result = []
#      activities.each do |a|
#        if a.target != nil
#          if a.target.class.to_s == "Review"
#            #puts a.target.reviewable
#            @result << a.target.reviewable
#          elsif a.target.class.to_s == "Photo"
#            #puts a.target.photoable
#            @result << a.target.photoable
#          end
#        end
#      end
#      puts @result
#      puts ".."
#      @result.uniq!
#      Kaminari.paginate_array(@result).page(params[:page]).per(10)

#      if (a < c)
#        if (b < d)
#          @result = City.where("(latitude BETWEEN ? AND ?) AND (longitude BETWEEN ? AND ?)", a, c, b, d).includes(:country, :region, :reviews, :default_city_photo).order("favorite_cities_count DESC").page(params[:place_page]).per(30)
#        else
#          @result = City.where("(latitude BETWEEN ? AND ?) AND (longitude BETWEEN ? AND ?)", a, c, d, b).includes(:country, :region, :reviews, :default_city_photo).order("favorite_cities_count DESC").page(params[:place_page]).per(30)
#        end
#      else
#        if (b < d)
#          @result = City.where("(latitude BETWEEN ? AND ?) AND (longitude BETWEEN ? AND ?)", c, a, b, d).includes(:country, :region, :reviews, :default_city_photo).order("favorite_cities_count DESC").page(params[:place_page]).per(30)
#        else
#          @result = City.where("(latitude BETWEEN ? AND ?) AND (longitude BETWEEN ? AND ?)", c, a, d, b).includes(:country, :region, :reviews, :default_city_photo).order("favorite_cities_count DESC").page(params[:place_page]).per(30)
#        end
#      end

      bound = sort_bound(a, b, c, d)
      
      @result = City.where("(latitude BETWEEN ? AND ?) AND (longitude BETWEEN ? AND ?)", bound[0], bound[2], bound[1], bound[3]).includes(:country, :region, :reviews, :default_city_photo).order("favorite_cities_count DESC").page(params[:place_page]).per(50)
      @result_list = @result.map do |u|
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
          :type => "City",
          :last_review => u.reviews_count > 0 ? u.reviews.last.content : "",
          :last_reviewer => u.reviews_count > 0 ? u.reviews.last.creator.profile.full_name : "",
          :last_reviewer_path => u.reviews_count > 0 ? user_profile_path(u.reviews.last.creator) : ""
        }
      end
      puts ",,,,,,,,,,,,"
      @result.each do |r|
        print r.name + " "
        print r.latitude.to_s + " "
        print r.longitude.to_s + " "
        puts " "
      end
#      puts @result_list
    end

#    @activities = Activity.includes(:target, :user).page(params[:page]).per(10)
#    polymorphic_association_includes @activities, :target, {
#      Photo => [:photoable, :creator, :photo_album],
#      Review => [:creator, :review_photos, :reviewable],
#      Event => [{:creator => :profile_photo}, :place]
#    }

    respond_to do |format|
      format.html
      format.js
    end
  end

  def news_feed
    @activities = Activity.page(params[:page]).per(10)
#    @my_activities = Activity.where("user_id = ?", current_user.id).includes(:target, :user)
#    @activities = Activity.joins('INNER JOIN users ON users.id = activities.user_id INNER JOIN friendships ON friendships.friend_id = users.id').where(["friendships.user_id = ?", current_user]).includes(:target, :user)
#    @activities = @my_activities + @activities
#    @activities = Kaminari.paginate_array(@activities.sort {|a,b| b.created_at <=> a.created_at}).page(params[:page]).per(10)

#    token = current_user.authentications.find_by_provider("facebook")
#    puts token.token
#    @graph = Koala::Facebook::API.new(token.token)
#    puts "------------------home ctrl/----------------"
#    puts @graph
#    @profile_image = @graph.get_picture("me")
#    puts @profile_image
#@graph.put_wall_post("Hello there!", {
#  "name" => "Link name",
#  "link" => "http://www.example.com/",
#  "caption" => "{*actor*} posted a new review",
#  "description" => "This is a longer description of the attachment",
#  "picture" => "http://www.example.com/thumbnail.jpg"
#})

#    @graph.put_wall_post("home", {:name => "place1", :link => "http://youtu.be/EYKO1za5mX0"})

#    @friends_reviews = Review.includes(:place, :review_photos, :creator => [:profile, :profile_photo]).where(creator_id: [current_user.id, current_user.friend_ids]).order('created_at DESC').page(params[:page]).per(10)
    @recent_reviews = Review.includes({:place => [:category, {:city => [:region, :country]}]}, :review_photos, :creator => [:profile, :profile_photo]).order('created_at DESC').page(params[:page]).per(10)

#    @friends_photos = Photo.public_photo.includes(:photo_album, :creator => [:profile_photo, :profile]).where(creator_id: [current_user.id, current_user.friend_ids]).order('photos.created_at DESC').page(params[:page]).per(10)
    @recent_photos = Photo.public_photo.place_photo.includes(:photo_album, :creator => [:profile_photo, :profile]).order('photos.created_at DESC').page(params[:page]).per(10)
#    @friends_photos = Photo.public_photo.joins(:photo_album).where("photo.photo_album.creator_id in (?)", current_user.friend_ids).order('photos.created_at DESC').page(params[:page]).per(10)

#    @reviews = @place.reviews.by_votes.includes({:creator => [{:profile_photo => :photo}, :profile]}, :review_photos).page(params[:review_page]).per(5)

    # sidebar infos
    @popular_places = Place.includes({:city => [:country, :region]}, :category).order("favorite_places_count DESC").limit(10)

    @most_reviewed_places = Place.includes({:city => [:country, :region]}, :category).order("reviews_count DESC").limit(10)

#    @timeline = current_user.timeline.limit(10)

    respond_to do |format|
      format.js
      format.html # index.html.erb
#      format.xml  { render :xml => @activities }
    end
  end

  
end
