class FriendshipController < ApplicationController  
  before_filter :authenticate_user_from_token!, :authenticate_user!
  before_filter :setup_friends, :except => [:show]

  # Send a friend request.
  # We'd rather call this "request", but that's not allowed by Rails.
  def create
    Friendship.request(@user, @friend)
    EmailsWorker.perform_async(@user.id, @friend.id)
#    UserMailer.friend_request(@user, @friend).deliver
    flash[:notice] = t(:friend_request_sent)
    redirect_back_or_default(user_profile_path(@friend))
  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = t(:friendship_accepted)
    else
      flash[:notice] = t(:no_friendship_request)
    end
    redirect_back_or_default(friendship_show_path)
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = t(:friendship_declined)
    else
      flash[:notice] = t(:no_friendship_request)
    end
    redirect_back_or_default(friendship_show_path)
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = t(:friendship_canceled)
    else
      flash[:notice] = t(:no_friendship_request)
    end
    redirect_back_or_default(friendship_show_path)
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = t(:friendship_deleted)
    else
      flash[:notice] = t(:not_friend)
    end
    redirect_to friendship_show_path
  end

  def show
    @pending_friends = current_user.pending_friends.page(params[:pending_page]).per(10)
    @requested_friends = current_user.requested_friends.page(params[:requested_page]).per(10)

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  def friends
    @user = User.find_by_id(params[:id])
    if !@user.nil?
      @users = @user.friends.page(params[:page]).per(2)
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default(user_profile_path(current_user, current_user.profile))
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  private

  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end

end
