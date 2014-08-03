class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  acts_as_tree

  has_many :places, :inverse_of => :category

  validates :name, :presence => true

  #main category
  ACCOMODATION = 1
  SHOPPING = 2
  SIGHTSEEING = 3
  EATING = 4
  SPORT = 5
  OTHER = 6
  HEALTH = 156
  BANK = 210

  scope :main_category, where("parent_id IS ?", nil)
  scope :subcategory, where("parent_id IS NOT ?", nil)

end
