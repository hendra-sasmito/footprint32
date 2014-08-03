class CommentsWorker
  include Sidekiq::Worker
  
  def perform(user_id, friend_id, comment_id)
    user = User.find_by_id(user_id)
    friend = User.find_by_id(friend_id)
    UserMailer.receive_comment(user, friend, comment_id).deliver
  end
end

