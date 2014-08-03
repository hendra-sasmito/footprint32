class ReviewVote < ActiveRecord::Base
  attr_accessible :value, :review #, :review_id

  belongs_to :review, :inverse_of => :review_votes
  belongs_to :user, :inverse_of => :review_votes

  validates :user, :presence => true
  validates :review, :presence => true
  validates_uniqueness_of :review_id, scope: :user_id
  validates :value, :presence => true
  validates_inclusion_of :value, in: [1, -1]
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the review" if review.creator_id == user_id
  end

  def place
    review.place
  end

  scope :likes, where("value = ?", 1)
  scope :dislikes, where("value = ?", -1)
end
