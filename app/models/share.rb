class Share < ActiveRecord::Base
  attr_accessible :share_event, :share_photo, :share_review, :provider

  belongs_to :user
  validates :user, :presence => true
  validates :provider, :presence => true
end
