class EventObserver < ActiveRecord::Observer
  def after_save(event)
#    Activity.add(event.creator, Activity::CREATE_EVENT, event, event)
  end

  def before_destroy(event)
    Activity.destroy_all(:activity_type => Activity::CREATE_EVENT,:target_id => event.id)
  end
end
