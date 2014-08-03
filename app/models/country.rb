class Country < ActiveRecord::Base
  attr_accessible :name
  has_many :cities, :inverse_of => :country
  has_many :places, :through => :cities
  has_many :regions, :inverse_of => :country

  validates :name, :presence => true

  searchable do
    text :name
  end

end
