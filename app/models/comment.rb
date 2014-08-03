class Comment < ActiveRecord::Base
  #attr_accessible :commentable_id, :commentable_type, :content, :user_id
  attr_accessible :commentable_type, :content #:commentable_id, 

  has_many :activities, :as => :target, :dependent => :destroy

  has_many :reports, :as => :reportable
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user, :inverse_of => :comments

  validates :user, :presence => true
  validates :content, :presence => true
  validates :commentable_id, :presence => true
  validates :commentable_type, :presence => true

end
