class EmailsWorker
  include Sidekiq::Worker
  
  def perform(user_id, friend_id)
    user = User.find_by_id(user_id)
    friend = User.find_by_id(friend_id)
    UserMailer.friend_request(user, friend).deliver
  end
end

