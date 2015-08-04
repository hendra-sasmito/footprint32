class FriendshipObserver < ActiveRecord::Observer
  def after_accept(friendship)
#    Activity.add(friendship.user, Activity::HAVE_NEW_FRIEND, friendship, friendship)
  end

  def before_breakup(friendship)
#    Activity.destroy_all(:activity_type => Activity::HAVE_NEW_FRIEND, :target_id => friendship.id)
  end
end
