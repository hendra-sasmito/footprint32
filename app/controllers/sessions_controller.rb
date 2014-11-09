class SessionsController < Devise::SessionsController

  def create
    # Take into account acts_as_paranoid deleted users
    if (resource = User.only_deleted.find_by_email(params[:user][:email]))
      # Copied from Warden::Strategies database_authenticatable:
      if resource.valid_password?(params[:user][:password])
        resource.recover
        sign_in resource
      end
    end
    super
  end

  def destroy
    super
    puts "..........dest"
    session[:user_id] = nil
    sleep 3
#    root_url
#    redirect_to root_url, :notice => "Signed out!"

  end
  
end
