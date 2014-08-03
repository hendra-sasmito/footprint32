class Profile < ActiveRecord::Base
  belongs_to :user, :inverse_of => :profile
  belongs_to :profile_photo, :class_name => "Photo", :foreign_key => "profile_photo_id"
  belongs_to :cover_photo, :class_name => "Photo", :foreign_key => "cover_photo_id"
  belongs_to :location, :class_name => "Place", :foreign_key => "location_id"
  belongs_to :hometown, :class_name => "City", :foreign_key => "hometown_id"

  attr_accessible :about, :birthdate, :first_name, :gender, :last_name, :time_zone, :language, :location_id, :profile_photo_id, :cover_photo_id, :hometown_id

  VALID_GENDER = %w(m f u M F U)

#  validates :user, :presence => true
  validates :first_name, :presence => {:message => "First name can't be empty"}
  validates :last_name, :presence => {:message => "Last name can't be empty"}
  validates_inclusion_of :gender, :in => VALID_GENDER, :message => "Gender is not valid", :allow_blank => true
  validates_date :birthdate, :allow_blank => true, :invalid_date_message => "Birthdate is not valid"

#  START_YEAR = 1900
#  VALID_DATES = DateTime.new(START_YEAR)..DateTime.now

#  validates_inclusion_of    :birthdate,
#                            :in => VALID_DATES,
#                            :message => "is invalid"

  #validates_inclusion_of    :gender,
  #                          :in => %w( m f M F),
  #                          :message => "must be male or female"

  def full_name
    [first_name.capitalize, last_name.capitalize].join(' ')
  end

#  private
#
#  def birthdate_is_date?
#    if !birthdate.is_a?(Date)
#      errors.add(:birthdate, 'must be a valid date')
#    end
#  end

end
