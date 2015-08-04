class Activity < ActiveRecord::Base
  attr_accessible :activity_type, :target_id, :target_type, :user_id

  belongs_to :user #, :inverse_of => :activities
  belongs_to :target, :polymorphic => true
  attr_accessible :target
  belongs_to :friendship, :foreign_key => "user_id"
#  belongs_to :photo
#  belongs_to :review

  # valid activity_type
  CREATE_REVIEW               = 1
  UPLOAD_PHOTO                = 2
  VOTE_REVIEW                 = 3
  CHANGE_LOCATION             = 4
  ADD_FAVORITE_PLACE          = 5
  HAVE_NEW_FRIEND             = 6
  CHANGE_PROFILE_PHOTO        = 7
  ADD_VISITED_PLACE           = 8
  CREATE_COMMENT              = 9
  CREATE_EVENT                = 10
  ADD_FAVORITE_CITY           = 11
  ADD_VISITED_CITY            = 12
    
  VALID_ACCESS = [CREATE_REVIEW, UPLOAD_PHOTO, VOTE_REVIEW, CHANGE_LOCATION, ADD_FAVORITE_PLACE, HAVE_NEW_FRIEND, CHANGE_PROFILE_PHOTO, ADD_VISITED_PLACE, CREATE_COMMENT, CREATE_EVENT, ADD_FAVORITE_CITY, ADD_VISITED_CITY]

  # validation
  validates :user_id, :presence => true
  validates :activity_type, :presence => true
  validates :target_id, :presence => true
  validates :target_type, :presence => true
  validates_inclusion_of    :activity_type,
                            :in => VALID_ACCESS,
                            :message => "is invalid"

  default_scope :order => 'activities.created_at DESC'

  class << self
    def add(user, activity_type, target, target_object)
      return false if user.blank? or activity_type.blank? or target.blank?
      activity = Activity.create!(:user_id => user.id, :activity_type => activity_type, :target_type => target.class.name, :target_id => target_object.id)
#      PrivatePub.publish_to("/activities/new", '$("#results_endless").before("<%= escape_javascript(render :partial => "home/activity", :collection => "#{activity}" %>");')
#      PrivatePub.publish_to("/activities/new", activity: activity)
#      PrivatePub.publish_to("/activities/new", "$('#new_newsfeed').append('<%= escape_javascript(render(:partial => 'home/activity', :collection => '#{activity}')) %>');")
      
    end
  end
end
