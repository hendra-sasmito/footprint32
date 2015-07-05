# file: app/controller/api/v1/sessions_controller.rb
class Api::V1::SessionsController < Devise::SessionsController
  acts_as_token_authentication_handler_for User
#  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
#    puts "--create--"
#    puts resource_name
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
#    puts resource
    sign_in(resource_name, resource)
    current_user.reset_authentication_token!
    current_user.save
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { :auth_token => current_user.authentication_token, :user_id => current_user.id } }
  end

  def destroy
#    puts "--destroy--"
#    puts resource_name
#    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")

    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)
    
    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      user.update_column(:authentication_token, nil)
      user.save
      render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
    else
#      puts "authenticate_user_from_token! failed"
      render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
    end
  end

  def failure
#    puts "failure"
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
end