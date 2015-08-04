class ReviewVoteObserver < ActiveRecord::Observer
  def after_save(review_vote)
#    Activity.add(review_vote.user, Activity::VOTE_REVIEW, review_vote, review_vote)
  end

  def before_destroy(review_vote)
#    Activity.destroy_all(:activity_type => Activity::VOTE_REVIEW, :target_id => review_vote.id)
  end
end
