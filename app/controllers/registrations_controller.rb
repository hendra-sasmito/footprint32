# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?
    puts "-----------------"
    puts @token
  end

  def destroy
    puts '.............destroy...........'
    redirect_back_or_default()
  end
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
      @user.skip_confirmation!
      @user.confirm!
    end
  end

end