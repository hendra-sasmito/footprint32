class FavoriteCity < ActiveRecord::Base
  attr_accessible :city_id #, :user_id

  belongs_to :user, :inverse_of => :favorite_cities
  belongs_to :city, :counter_cache => true

  validates :user, :presence => true
  validates :city, :presence => true

  has_many :activities, :as => :target, :dependent => :destroy
end
