class ReviewPhoto < ActiveRecord::Base
  attr_accessible :image, :review_id

  belongs_to :review, :inverse_of => :review_photos

  has_attached_file :image,
     :styles => {
       :original => "950x400>",
       :small  => "285x180#" },
       :source_file_options => { :all => '-auto-orient' },
       :url => "/system/review/:attachment/:id/:style/:basename.:extension",
       :path => ":rails_root/public/system/review/:attachment/:id/:style/:basename.:extension"

  validates_attachment :image, :presence => true,
    :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png'] }
  validates_attachment_size :image, :less_than => 15.megabytes

  def place
    review.place
  end
  
end
