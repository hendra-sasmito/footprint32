class Report < ActiveRecord::Base
  attr_accessible :reportable_id, :reportable_type, :reason, :comment #:user_id

  belongs_to :reportable, :polymorphic => true
  belongs_to :user

  # reason
  INAPPROPRIATE               = 1
  DUPLICATE                   = 2
  CLOSED                      = 3
  NOT_EXIST                   = 4

  validates :user, :presence => true
  validates :reason, :presence => true
  validates :reportable_id, :presence => true
  validates :reportable_type, :presence => true

  validates_uniqueness_of :user_id, scope: [:reportable_type, :reportable_id]
end
