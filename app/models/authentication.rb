class Authentication < ActiveRecord::Base
  belongs_to :user, :inverse_of => :authentications

  attr_accessible :provider, :uid, :token, :token_secret #:user_id, 

  validates :user, :presence => true
  validates :provider, :presence => true
  validates :uid, :presence => true
end