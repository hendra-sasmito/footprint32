class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def google_oauth2
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
    if authentication
      flash[:notice] = "Logged in Successfully"
      user = User.with_deleted.find(authentication.user_id)
      if !user.deleted_at.nil?
        # recover user account
        user.recover
      end
      sign_in_and_redirect user
    elsif current_user
      token = omni['credentials'].token
      token_secret = ""
      # add authentication to current_user
      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
    else
      user = User.find_by_email(omni['extra']['raw_info'].email)
      if user.nil?
        # create new user
        user = User.new
        user.email = omni['extra']['raw_info'].email
        user.apply_omniauth(omni)
        user.build_profile(:first_name => omni['extra']['raw_info'].given_name,
                           :last_name => omni['extra']['raw_info'].family_name)
        user.photo_albums.build(:name => "Profile Album",
                             :description => "Profile Pictures",
                             :privacy => Footprint32::PUBLIC,
                             :default => 1)
        user.skip_confirmation!
        user.confirm!
        if user.save
          flash[:notice] = "Logged in."
          sign_in_and_redirect User.find(user.id)
        else
          session[:omniauth] = omni.except('extra')
          redirect_to new_user_registration_path
        end
      else
        token = omni['credentials'].token
        token_secret = ""
        # add authentication to user
        user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
        flash[:notice] = "Authentication successful."
        sign_in_and_redirect user
      end
    end
  end
  
  def facebook
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
    if authentication
      flash[:notice] = "Logged in Successfully"
      user = User.with_deleted.find(authentication.user_id)
      if !user.deleted_at.nil?
        # recover user account
        user.recover
      end
      sign_in_and_redirect user
    elsif current_user
      token = omni['credentials'].token
      token_secret = ""
      # add authentication to current_user
      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      current_user.shares.create!(:provider => omni['provider'], :share_review => false, :share_event => false, :share_photo => false)
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
    else
      user = User.find_by_email(omni['extra']['raw_info'].email)
      if user.nil?
        # create new user
        user = User.new
        user.email = omni['extra']['raw_info'].email
        user.apply_omniauth(omni)
        user.build_profile(:first_name => omni['extra']['raw_info'].first_name,
                           :last_name => omni['extra']['raw_info'].last_name)
        user.photo_albums.build(:name => "Profile Album",
                             :description => "Profile Pictures",
                             :privacy => Footprint32::PUBLIC,
                             :default => 1)
        user.skip_confirmation!
        user.confirm!
        if user.save
          user.shares.create!(:provider => omni['provider'], :share_review => false, :share_event => false, :share_photo => false)
          flash[:notice] = "Logged in."
          sign_in_and_redirect User.find(user.id)
        else
          session[:omniauth] = omni.except('extra')
          redirect_to new_user_registration_path
        end
      else
        token = omni['credentials'].token
        token_secret = ""
        # add authentication to user
        user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
        user.shares.create!(:provider => omni['provider'], :share_review => false, :share_event => false, :share_photo => false)
        
        flash[:notice] = "Authentication successful."
        sign_in_and_redirect user
      end
    end
  end

  def twitter
     omni = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
     if authentication
      flash[:notice] = "Logged in Successfully"
      user = User.with_deleted.find(authentication.user_id)
      if !user.deleted_at.nil?
        # recover user account
        user.recover
      end
      sign_in_and_redirect user
     elsif current_user
       token = omni['credentials'].token
       token_secret = omni['credentials'].secret
       # add authentication to current_user
       current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
       flash[:notice] = "Authentication successful."
       sign_in_and_redirect current_user
     else
       user = User.new
       user.apply_omniauth(omni)
       user.build_profile(:first_name => omni['extra']['raw_info'].first_name,
                             :last_name => omni['extra']['raw_info'].last_name)
       user.photo_albums.build(:name => "Profile Album",
                             :description => "Profile Pictures",
                             :privacy => Footprint32::PUBLIC,
                             :default => 1)
       # don't need to confirm email
       user.skip_confirmation!
       user.confirm!
       if user.save
         flash[:notice] = "Logged in."
         sign_in_and_redirect User.find(user.id)
       else
         session[:omniauth] = omni.except('extra')
         redirect_to new_user_registration_path
       end
     end
   end
end