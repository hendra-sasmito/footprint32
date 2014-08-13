class Photo < ActiveRecord::Base
  attr_accessible :description, :image, :place_id #, :photo_album_id

  belongs_to :user, :inverse_of => :photos
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id, :inverse_of => :photos
  belongs_to :photo_album, :inverse_of => :photos
  has_one :profile_photo_owner, :class_name => "Profile", :foreign_key => "profile_photo_id", :dependent => :nullify
  has_one :cover_photo_owner, :class_name => "Profile", :foreign_key => "cover_photo_id", :dependent => :nullify
#  belongs_to :place
  belongs_to :photoable, :polymorphic => true
  #belongs_to :city, foreign_key: 'photoable_id', conditions: "photos.photoable_type = 'City'"
  #belongs_to :place, foreign_key: 'photoable_id', conditions: "photos.photoable_type = 'Place'"
  has_many :activities, :as => :target, :dependent => :destroy

  has_many :reports, :as => :reportable

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :latest_comments, :class_name => "Comment", :as => :commentable, :limit => 1

  attachment_virtual_path = "/system/photo/:attachment/:hashed_path/:id/:style/:basename.:extension"
  attachment_real_path = ":rails_root/public" + attachment_virtual_path
  
  has_attached_file :image,
     :styles => {
       :original => "950x", #"950x400>",
       :thumb => "100x100#",
       :small  => "400x" }, #"285x180#" },
       :source_file_options => { :all => '-auto-orient' },
       :url => "/system/photo/:attachment/:id/:style/:basename.:extension",
       :path => ":rails_root/public/system/photo/:attachment/:id/:style/:basename.:extension",
       :default_url => lambda { |a| "#{a.instance.create_default_url}" }

  JPEG_IMAGE = 'image/jpeg'
  JPG_IMAGE = 'image/jpg'
  PNG_IMAGE = 'image/png'

  validates_attachment :image, :presence => true,
    :content_type => { :content_type => [JPEG_IMAGE, JPG_IMAGE, PNG_IMAGE] }
  validates_attachment_size :image, :less_than => 15.megabytes
  validates :photo_album, :presence => true
#  validates :creator, :presence => true

#  default_scope includes(:creator, :photoable, :photo_album)
#  default_scope includes(:creator, :photo_album)
  
  scope :private_photo, joins(:photo_album).where("privacy = ?", Footprint32::PRIVATE)
  scope :friends_photo, joins(:photo_album).where("privacy = ?", Footprint32::FRIENDS)
  scope :public_photo, joins(:photo_album).where("privacy = ?", Footprint32::PUBLIC)
  scope :shared_photo, joins(:photo_album).where("privacy <> ?", Footprint32::PRIVATE)

  scope :place_photo, where("photos.place_id is not NULL")

  include Rails.application.routes.url_helpers
  #Rails.application.routes.url_helpers.photo_path(self)

  def to_jq_upload
    {
      "name" => read_attribute(:image_file_name),
      "size" => read_attribute(:image_file_size),
      "url" => image.url,
      "thumbnail_url" => image.url(:thumb),
      #"photo_url" => "/users/{#{creator_id}}/photo_albums/#{photo_album_id}/photos/#{id}",
      #"delete_url" => "/users/{#{creator_id}}/photo_albums/#{photo_album_id}/photos/#{id}", #user_photo_album_photo_url(creator_id, photo_album_id, id), #
      #"photo_url" => user_photo_album_photo_path(self.creator, self.photo_album, self),
      #"delete_url" => user_photo_album_photo_path(self.creator, self.photo_album, self),
      #"photo_url" => self.image.url,
#      "delete_url" => user_photo_album_photo_path(self.photo_album.creator, self.photo_album, self),
      "delete_url" => user_photo_album_photo_path(self.creator, self.photo_album, self),
      "delete_type" => "DELETE"
    }
  end

  def photo_album_creator
    creator
  end
  
  def photo_album_creator_id
    creator.id
  end

  def create_default_url
    ActionController::Base.helpers.asset_path("city.png", :digest => false)
  end

end
