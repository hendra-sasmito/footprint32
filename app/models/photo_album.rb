class PhotoAlbum < ActiveRecord::Base
  attr_accessible :description, :name, :privacy, :default

  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id, :inverse_of => :photo_albums
  has_many :photos, :inverse_of => :photo_album, :dependent => :destroy
  has_many :comments, :through => :photos, :dependent => :destroy
  belongs_to :albumable, :polymorphic => true
#  has_many :activities, :as => :target, :through => :photo, :dependent => :destroy

  # 0 = public
  # 1 = friends
  # 2 = private
  VALID_ACCESS = [Footprint32::PUBLIC, Footprint32::FRIENDS, Footprint32::PRIVATE]

  validates :name, :presence => true #, :photo_album_name => true
  validates :privacy, :presence => true
#  validates :creator, :presence => true
  validates_inclusion_of    :privacy,
                            :in => VALID_ACCESS,
                            :message => "is invalid"

  scope :private_photo_album, where("privacy = ?", Footprint32::PRIVATE)
  scope :friends_photo_album, where("privacy = ?", Footprint32::FRIENDS)
  scope :public_photo_album, where("privacy = ?", Footprint32::PUBLIC)
  scope :shared_photo_album, where("privacy <> ?", Footprint32::PRIVATE)
  

#  def allowed_photo_album_name
#    if name == "Profile Album"
#      errors.add(:name, "can't be Photo Album")
#    end
#  end

#  validate :cant_be_profile_album
#  def cant_be_profile_album
#    errors.add(:name, "can't be something") if self.name == "Profile Album"
#  end

end
