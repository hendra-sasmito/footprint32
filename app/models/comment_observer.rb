class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    Activity.add(comment.user, Activity::CREATE_COMMENT, comment, comment)
  end

  def before_destroy(comment)
    Activity.destroy_all(:activity_type => Activity::CREATE_COMMENT, :target_id => comment.id)
  end
end
