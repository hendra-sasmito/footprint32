class FavoritePlace < ActiveRecord::Base
  attr_accessible :place_id #:user_id
  belongs_to :user, :inverse_of => :favorite_places
  belongs_to :place, :counter_cache => true

  validates :user, :presence => true
  validates :place, :presence => true

  has_many :activities, :as => :target, :dependent => :destroy
end
