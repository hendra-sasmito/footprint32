class VisitedCity < ActiveRecord::Base
  attr_accessible :city_id #, :user_id

  belongs_to :user
  belongs_to :city, :counter_cache => true

  validates :user, :presence => true
  validates :city, :presence => true

  has_many :activities, :as => :target, :dependent => :destroy
end
