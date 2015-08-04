class ReviewObserver < ActiveRecord::Observer

  def after_create(review)
#    Activity.add(review.creator, Activity::CREATE_REVIEW, review, review)
  end

  def before_destroy(review)
#    Activity.destroy_all(:activity_type => Activity::CREATE_REVIEW, :target_id => review.id)
  end

end
