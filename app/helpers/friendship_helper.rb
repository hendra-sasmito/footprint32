module FriendshipHelper

  # get friendship status
  def friendship_status(user, friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    if friendship.nil?
      return 'not a friend'
    else
      return friendship.status
    end
  end

end
