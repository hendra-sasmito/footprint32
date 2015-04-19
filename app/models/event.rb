class Event < ActiveRecord::Base
  attr_accessible :description, :name, :privacy, :date, :place_id
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id, :inverse_of => :events
  belongs_to :place, :inverse_of => :events

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :activities, :as => :target, :dependent => :destroy
  # privacy value
  # 0 = public
  # 1 = friends
  VALID_ACCESS = [Footprint32::PUBLIC, Footprint32::FRIENDS]

  PAST_EVENT = "1"
  INCOMING_EVENT = "0"

  validates :name, :presence => true
  validates :place, :presence => true
  validates :creator, :presence => true
  validates :date, :presence => true
  validates_datetime :date, :after => DateTime.now.in_time_zone
  
  validates :privacy, :presence => true
  validates_inclusion_of    :privacy,
                            :in => VALID_ACCESS,
                            :message => "is invalid"

  scope :friends_event, where("privacy = ?", Footprint32::FRIENDS).order('date ASC')
  scope :incoming_event, where("date >= ?", Time.zone.now).order('date ASC')
  scope :public_event, where("privacy = ?", Footprint32::PUBLIC).order('date ASC')
  scope :past_event, where("date < ?", Time.zone.now).order('date ASC')

#  scope :from_this_month, where("date > ? AND < ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
#  scope :date, lambda {|date| where('date_field > ? AND date_field < ?', DateTime.parse(date).beginning_of_day, DateTime.parse(date).end_of_day}
  scope :by_month, lambda {|date| where('date > ? AND date < ?', DateTime.parse(date).in_time_zone.beginning_of_month, DateTime.parse(date).in_time_zone.end_of_month)}

  def city
    place.city
  end
end
