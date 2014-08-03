class Trip < ActiveRecord::Base
  attr_accessible :description, :name, :datalog, :privacy

  belongs_to :user

  has_attached_file :datalog

  validates :name, :presence => true
  validates_attachment :datalog, :presence => true

  scope :private_trip, where("privacy = ?", Footprint32::PRIVATE)
  scope :friends_trip, where("privacy = ?", Footprint32::FRIENDS)
  scope :public_trip, where("privacy = ?", Footprint32::PUBLIC)
  scope :shared_trip, where("privacy <> ?", Footprint32::PRIVATE)
end
