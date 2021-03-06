class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery
  # Prevent CSRF attacks by raising an exception.
#  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :store_location, :set_user_time_zone, :set_locale
  after_filter :flash_to_headers

  config.relative_url_root = ""

#  def authenticate_user_from_token!
#    user_token = params[:auth_token].presence
#    puts "--authenticate_user_from_token!--"
#    puts user_token
#    user = user_token && User.find_by_authentication_token(user_token.to_s)
#
#    if user
#      sign_in user, store: false
#    else
#      puts "authenticate_user_from_token! failed"
#      render :status => 401,
#           :json => { :success => false,
#                      :info => "Login Failed",
#                      :data => {} }
#    end
#  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)
#    puts "--authenticate_user_from_token!--"
#    puts user_email

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      sign_in user, store: false
#    else
#      puts "authenticate_user_from_token! failed"
#      render :status => 401,
#           :json => { :success => false,
#                      :info => "Login Failed",
#                      :data => {} }
    end
  end
#  acts_as_token_authentication_handler_for User
  
#  def after_sign_in_path_for(resource_or_scope)
#    session[:my_account] = current_location = request.location
#    super
#    places_path
#  end

#  def current_user
#    @current_user ||= super && User.includes(:profile, :profile_photo).find(@current_user.id)
#  end

  def store_location
   if ((!request.fullpath.match("/users") && !request.fullpath.match("/admin") && !request.fullpath.match("/admin/login")) &&
    !request.xhr?) # don't store ajax calls
#    puts "----------------------------"
#    puts "--not store--"
    session[:previous_url] = request.fullpath
   else
#    puts "----------------------------"
#    puts "--store--"
   end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def is_user_allowed(user, privacy)
    case privacy
    when Footprint32::PRIVATE
      if (user == current_user)
        return true
      else
        return false
      end
    when Footprint32::FRIENDS
      if ((user == current_user) or (Friendship.is_friend?(current_user, user)))
        return true
      else
        return false
      end
    else # Footprint32::PUBLIC
      return true
    end
  end

  def redirect_back_or_default(default = root_path, *options)
    tag_options = {}
    options.first.each { |k,v| tag_options[k] = v } unless options.empty?
    redirect_to (request.referer.present? ? :back : default), tag_options
  end

  def flash_to_headers
    return unless request.xhr?
    msg = flash_message

    response.headers['X-Message'] = msg

    response.headers["X-Message-Type"] = flash_type.to_s

    flash.discard # don't want the flash to appear when you reload page
  end

  protected

  private
  def set_user_time_zone
    if user_signed_in?
      if current_user.profile.time_zone
        Time.zone = current_user.profile.time_zone
      else
        Time.zone = "Berlin"
      end
    end
  end

  def set_locale
#    I18n.locale = user_signed_in? ? current_user.profile.language.to_sym : I18n.default_locale
  end

  # flash message
  def flash_message
    [:error, :warning, :notice].each do |type|
        return flash[type] unless flash[type].blank?
    end
    # if we don't return something here, the above code will return "error, warning, notice"
    return ''
  end

  def flash_type
    [:error, :warning, :notice].each do |type|
        return type unless flash[type].blank?
    end
  end

#  def sort_bound(a, b, c, d)
#    temp = []
#    if (a < c)
#      if (b < d)
#        temp << a
#        temp << b
#        temp << c
#        temp << d
#      else
#        temp << a
#        temp << d
#        temp << c
#        temp << b
#      end
#    else
#      if (b < d)
#        temp << c
#        temp << b
#        temp << a
#        temp << d
#      else
#        temp << c
#        temp << d
#        temp << a
#        temp << b
#      end
#    end
#    return temp
#  end
  
  def sort_bound(a, b, c, d)
    if (a < c)
      if (b < d)
        temp = [a, b, c, d]
      else
        temp = [a, d, c, b]
      end
    else
      if (b < d)
        temp = [c, b, a, d]
      else
        temp = [c, d, a, b]
      end
    end
    return temp
  end

end
class UnauthorizedException < Exception; end