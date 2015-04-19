class Review < ActiveRecord::Base
  attr_accessible :content, :review_photos_attributes, :reviewable_type, :reviewable_id #, :creator_id

#  include Rediline::Object
#
#  rediline :timeline,
#      :user => :creator,
#      :verb => :created,
#      :when => :after_create

  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id, :counter_cache => true, :inverse_of => :reviews
#  belongs_to :place, :counter_cache => true, :inverse_of => :reviews

  belongs_to :reviewable, :polymorphic => true, :counter_cache => true
  has_many :activities, :as => :target, :dependent => :destroy

  has_many :reports, :as => :reportable

  validates :creator, :presence => true
#  validates :place, :presence => true
  validates :reviewable_id, :presence => true
  validates :reviewable_type, :presence => true
  validates :content, :presence => true

#  belongs_to :user

  has_many :review_votes, :dependent => :destroy, :inverse_of => :review
  has_many :review_photos, :dependent => :destroy, :inverse_of => :review
#  accepts_nested_attributes_for :review_photos, :allow_destroy => true
  accepts_nested_attributes_for :review_photos, :reject_if => lambda { |a| a[:image].blank? }, :allow_destroy => true

  def self.by_votes
    select('reviews.*, coalesce(value, 0) as votes').
    joins('left join review_votes on review_id=reviews.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || review_votes.sum(:value)
  end

  def likes
    read_attribute(:votes) || review_votes.likes.count
  end

  def dislikes
    read_attribute(:votes) || review_votes.dislikes.count
  end

#  scope :popular, lambda do |time|
#    where("created_at < ?", DateTime.now.in_time_zone - 1.week).select("place_id, count(place_id) as count").group(:place_id).order("count desc").limit(3)
#  end

#  scope :most_reviewed, select("place_id, count(place_id) as count").group(:place_id).order("count desc").limit(3)

  default_scope includes(:creator)
  scope :weekly_top_places, where("created_at > ?", DateTime.now.in_time_zone - 1.week).select("place_id, count(place_id) as count").group(:place_id).order("count desc")
  scope :weekly_top_reviewers, includes(:creator).where("created_at > ?", DateTime.now.in_time_zone - 1.week).select("creator_id, count(creator_id) as count").group(:creator_id).order("count desc")

#  scope :recent_friends_reviews, includes(:creator).where(creator_id: current_user.friend_ids).order('created_at DESC')
  
end
