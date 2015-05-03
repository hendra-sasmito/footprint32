class User < ActiveRecord::Base

  before_save :ensure_authentication_token
  acts_as_paranoid
  
  def ensure_authentication_token
    if authentication_token.blank?
        self.authentication_token = generate_authentication_token
    end
  end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
  end
  
#  acts_as_token_authenticatable
#  include Rediline::User
#
#  rediline :timeline do
#      list :egocentric do
#          [user]
#      end
#
#      list :public do
#          user.friends.all
#      end
#  end
#  acts_as_reader

#  include Timeline::Actor
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
         :lockable, :omniauthable, #:async,
         :validatable, :email_regexp =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
         :omniauth_providers => [:facebook, :google_oauth2] #:twitter

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessor :location, :hometown

  has_many :reports

  has_many :authentications, :inverse_of => :user
  
  has_one :profile, :inverse_of => :user
  attr_accessible :profile_attributes
  accepts_nested_attributes_for :profile

#  has_one :location
#  attr_accessible :location_attributes
#  accepts_nested_attributes_for :location

#  has_one :profile_photo
#  attr_accessible :profile_photo_attributes
#  accepts_nested_attributes_for :profile_photo

  has_one :profile_photo, :through => :profile, :inverse_of => :user
#  has_one :cover_photo, :through => :profile, :inverse_of => :user

  has_many :friendships
  has_many :friends,
    :through => :friendships,
    :conditions => "status = 'accepted'"
  has_many :requested_friends,
    :through => :friendships,
    :source => :friend,
    :conditions => "status = 'requested'"
  has_many :pending_friends,
    :through => :friendships,
    :source => :friend,
    :conditions => "status = 'pending'"

  has_many :photo_albums, :foreign_key => "creator_id"
  attr_accessible :photo_albums_attributes
  accepts_nested_attributes_for :photo_albums

  has_many :photos, :through => :photo_albums, :foreign_key => "creator_id"
#  belongs_to :profile_photo, :class_name => "Photo", :foreign_key => "profile_photo_id"
#  attr_accessible :photos
#  accepts_nested_attributes_for :photos
  
  has_many :reviews, :foreign_key => "creator_id"

  has_many :friends_reviews, :through => :friends, :source => :reviews

  has_many :favorite_places
  has_many :my_favorite_places, :through => :favorite_places, :source => :place  
  has_many :friends_favorite_places, :through => :friends, :source => :favorite_places

  has_many :visited_places
  has_many :my_visited_places, :through => :visited_places, :source => :place
  has_many :friends_visited_places, :through => :friends, :source => :visited_places

  has_many :favorite_cities
  has_many :my_favorite_cities, :through => :favorite_cities, :source => :city

  has_many :visited_cities
  has_many :my_visited_cities, :through => :visited_cities, :source => :city

  has_many :review_votes

  has_many :events, :foreign_key => "creator_id"
  has_many :friends_events, :through => :friends, :source => :events

  has_many :comments

  has_many :conversations, :source => :sender
  has_many :message_statuses
  has_many :messages, :through => :message_statuses, :source => :message
  has_many :unread_messages, :through => :message_statuses, :source => :message,
    :conditions => ["message_statuses.status = ?", MessageStatus::UNREAD]
  has_many :read_messages, :through => :message_statuses, :source => :message,
    :conditions => ["message_statuses.status = ?", MessageStatus::READ]
  has_many :undeleted_messages, :through => :message_statuses, :source => :message,
    :conditions => ["message_statuses.status != ?", MessageStatus::DELETED]

  has_many :activities
  has_many :shares
  has_one :fb_share, :through => :shares, :source => :user,
    :conditions => ["provider = 'facebook'"]

  has_many :trips
  
  validates_associated :profile
#  validates_associated :location
#  validates_associated :profile_photo
  validates_associated :photo_albums

  searchable do
    text :email
    text :profile_first_name do
      profile.first_name
      #profile.nil?? '' : (profile.first_name.nil?? '' : profile.first_name)
    end
    text :profile_last_name do
      profile.last_name
      #profile.nil?? '' : (profile.last_name.nil?? '' : profile.last_name)
    end
  end

  scope :without_user, lambda{|user| user ? {:conditions => ["users.id != ?", user.id]} : {} }

  def total_votes
    ReviewVote.joins(:review).where(reviews: {creator_id: self.id}).sum('value')
  end

  def can_vote_for?(review)
    review_votes.build(value: 1, review: review).valid?
  end

  def liked?(review)
    self.review_votes.exists?(value: 1, review_id: review.id)
  end

  def disliked?(review)
    self.review_votes.exists?(value: -1, review_id: review.id)
  end

  def location
    profile.location
  end

  def hometown
    profile.hometown
  end

#  def voted_for?(review)
#    evaluations.where(:target_type => review.class, :target_id => review.id, :source_id => self.id).present?
#  end

#  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
#    if signed_in_resource
#      # if current_user is available, connect user account with facebook
#      if signed_in_resource.provider.nil? or signed_in_resource.uid.nil?
#        signed_in_resource.provider = auth.provider
#        signed_in_resource.uid = auth.uid
#        signed_in_resource.save!
#      end
#      user = signed_in_resource
#    else
#      # check if email is already exists
#      user = User.find_by_email(auth.info.email)
#      if !user.nil?
#        if user.provider.nil? or user.uid.nil?
#          user.provider = auth.provider
#          user.uid = auth.uid
#          user.save!
#        end
#      else
#        # create new user
#        user = User.where(:provider => auth.provider, :uid => auth.uid).first
#        #user = User.where(:email => auth.info.email).first
#        unless user
#          user = User.create(:provider => auth.provider,
#                               :uid => auth.uid,
#                               :email => auth.info.email #,
#                               #:password => Devise.friendly_token[0,20]
#                               )
#          profile = user.build_profile(
#                               :first_name => auth.info.first_name,
#                               :last_name => auth.info.last_name,
#                               )
#          photo_album = user.photo_albums.build(
#                               :name => "Profile Album",
#                               :description => "Profile Pictures",
#                               :privacy => Footprint32::PUBLIC
#                               )
#          profile_photo = user.build_profile_photo(
#                               )
#          location = user.build_location(
#                               )
#          # don't need to confirm email
#          user.skip_confirmation!
#        end
#      end
#
#    end
#    user
#  end

#  def self.find_for_twitter_oauth(omniauth)
#    user = User.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
#    if user
#      user
#    else
#      user = User.create!(:nickname => omniauth['nickname'],
#                            :name => omniauth['name'],
#                            :provider => omniauth['provider'], :uuid => omniauth['uid'])
#      profile = user.build_profile(
#                           :first_name => omniauth.nickname #,
##                           :last_name => auth.info.last_name,
#                           )
#      photo_album = user.photo_albums.build(
#                           :name => "Profile Album",
#                           :description => "Profile Pictures",
#                           :privacy => Footprint32::PUBLIC
#                           )
#      profile_photo = user.build_profile_photo(
#                           )
#      location = user.build_location(
#                           )
#      # don't need to confirm email
#      user.skip_confirmation!
#      user.save
#      user
#    end
#  end

#  def self.new_with_session(params, session)
#    super.tap do |user|
#      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
#        user.email = data["email"] if user.email.blank?
#      end
#    end
#  end

  def valid_password?(password)
    if !authentications.first.nil?
      !authentications.first.provider.nil? && !encrypted_password.present? || super(password)
    else
      super(password)
    end
  end


#  def self.apply_omniauth(omni)
#
#  end

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
                          :uid => omni['uid'],
                          :token => omni['credentials'].token,
                          :token_secret => omni['credentials'].secret)
#    user.build_profile(
#                         :first_name => omni['extra']['raw_info'].first_name,
#                         :last_name => omni['extra']['raw_info'].last_name
#                         )
#    user.photo_albums.build(
#                         :name => "Profile Album",
#                         :description => "Profile Pictures",
#                         :privacy => Footprint32::PUBLIC
#                         )
#    user.build_profile_photo()
#    user.build_location()
#    user.skip_confirmation!
#    user.confirm!
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super #&& provider.blank?
  end

#  def update_with_password(params, *options)
#    if encrypted_password.blank?
#      update_attributes(params, *options)
#    else
#      super
#    end
#  end

#  def skip_confirmation!
#    self.confirmed_at = Time.zone.now
#  end

  private
    def generate_authentication_token
        loop do
            token = Devise.friendly_token
            break token unless User.where(authentication_token: token).first
        end
    end
end
