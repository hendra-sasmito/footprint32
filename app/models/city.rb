class City < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :country_id, :region_id
  belongs_to :country, :inverse_of => :cities, :counter_cache => true
  belongs_to :region, :inverse_of => :cities
  has_many :places, :inverse_of => :city
  has_many :events, :through => :places

  has_many :photos, :as => :photoable, :dependent => :destroy
  has_many :photo_albums, :as => :albumable, :dependent => :destroy
  has_many :reviews, :as => :reviewable, :dependent => :destroy

  has_many :favorite_cities, :inverse_of => :city
  has_many :liked_users, :through => :favorite_cities, :source => :user
  has_many :visited_cities, :inverse_of => :city
  has_many :visited_users, :through => :visited_cities, :source => :user

  has_many :hometown_user, :class_name => "Profile", :foreign_key => "hometown_id"

  validates :name, :presence => true
  validates :country, :presence => true

  default_scope includes(:region, :country)

  def country_name
    country.name
  end

  searchable do
    text :name
    text :country do
      country.name if country
    end
  end
end
