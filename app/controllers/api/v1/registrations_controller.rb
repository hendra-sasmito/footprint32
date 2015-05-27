# file: app/controller/api/v1/registrations_controller.rb
class Api::V1::RegistrationsController < Devise::RegistrationsController

  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    build_resource(:email => params['user']['email'],
                   :password => params['user']['password'])
    resource.build_profile(:first_name => params['user']['first_name'],
                       :last_name => params['user']['family_name'])
    resource.photo_albums.build(:name => "Profile Album",
                         :description => "Profile Pictures",
                         :privacy => Footprint32::PUBLIC,
                         :default => 1)
    #resource.skip_confirmation!
    if resource.save
      sign_in resource
      render :status => 200,
           :json => { :success => true,
                      :info => "Registered, to complete the signup process, we need to confirm that you own the email address",
                      :data => { :user => resource,
                                 :auth_token => current_user.authentication_token } }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => resource.errors,
                        :data => {} }
    end
  end
end
