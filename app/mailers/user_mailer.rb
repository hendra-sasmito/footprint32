class UserMailer < ActionMailer::Base
  #default from: "from@example.com"
  default :from => "notifications@koedok.com"

  def welcome_email(user)
    @user = user
    @url  = '<%= Footprint32::Application.config.HOST_NAME %>'
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def friend_request(user, friend)
    @user = user
    @friend = friend
    mail(:to => friend.email, :subject => "New friend request at " + '<%= Footprint32::Application.config.HOST_NAME %>')
  end

  def receive_comment(user, friend, comment)
    @user = user
    @friend = friend
    @comment = comment
    mail(:to => friend.email, :subject => "Comment received at " + '<%= Footprint32::Application.config.HOST_NAME %>')
  end

end
