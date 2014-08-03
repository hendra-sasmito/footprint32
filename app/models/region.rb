class Region < ActiveRecord::Base
  attr_accessible :country_id, :name

  belongs_to :country, :inverse_of => :regions
  has_many :cities, :inverse_of => :region
end
