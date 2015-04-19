class Place < ActiveRecord::Base
  
  attr_accessible :latitude, :longitude, :name, :postcode, :street, :city_id, :description, :category_id

  geocoded_by :address
#  after_validation :geocode

  validates :name, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :latitude , numericality: { greater_than:  -90, less_than:  90 }
  validates :longitude, numericality: { greater_than: -180, less_than: 180 }
  validates :city, :presence => true

#  has_many :reports, :as => :reportable
  
  def country
    city.country
  end

  def address
    [street, city.name, postcode, country.name].compact.join(', ')
  end

  def short_address
    [street, city.name, country.name].compact.join(', ')
  end
#
#  def display_place_autocomplete
#    "#{name} - #{street}, #{city.name}"
#  end

#  has_many :photos, :inverse_of => :place
#  has_many :reviews, :inverse_of => :place
  has_many :photos, :as => :photoable, :dependent => :destroy
  has_many :photo_albums, :as => :albumable, :dependent => :destroy
  has_many :reviews, :as => :reviewable, :dependent => :destroy

  has_many :favorite_places, :inverse_of => :place
  has_many :liked_users, :through => :favorite_places, :source => :user
  has_many :visited_places, :inverse_of => :place
  has_many :visited_users, :through => :visited_places, :source => :user
  has_many :events, :inverse_of => :place

  belongs_to :category, :inverse_of => :places, :counter_cache => true
  belongs_to :city, :inverse_of => :places, :counter_cache => true

  has_many :location_user, :class_name => "Profile", :foreign_key => "location_id"
  has_many :review_photos, :through => :reviews

  has_many :default_photo, :order => 'photos.updated_at DESC', :limit => 1, :class_name => 'Photo', :as => :photoable

#  default_scope includes(:category, :city)
  scope :recently_created, where("created_at > ?", DateTime.now.in_time_zone - 1.week).order("created_at desc")
#  reverse_geocoded_by :latitude, :longitude do |obj,results|
#    if geo = results.first
#      obj.street = geo.address
#      obj.city = geo.city
#      obj.postcode = geo.postal_code
#      obj.state = geo.state
#      obj.country = geo.country_code
#    end
#  end
#  after_validation :reverse_geocode

  scope :with_city_country, includes(:city, :country)

  scope :popular, order("favorite_places_count DESC")

#  scope :public_photos, photos.includes(:photo_album).where("photo_album != ")

#  scope :education, joins(:category).where("category.name is ?", "Eduction")

#  scope :by_category, lambda do |category|
#    joins(:category).where('category.id = ?', category)
#  end

#  scope :by_category, lambda { |category| joins(:category).where("category.id = ?", category) }

  def self.by_category(category)
    where("category_id = ?", category)
  end

  searchable do
    text :name
    text :street
    text :city do
      city.name if city
    end
#    text :country do
#      city.country.name
#      text :country do
#        country.name if country
#      end
#    end
#    text :region do
#      city.region.name if region
#    end
#    text :country do
#      country.name if country
#    end
  end

  def cover_photo
    photos.last
  end
end
