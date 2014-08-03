module ApplicationHelper

  def facebook_like
    content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=standard&show_faces=false&width=80&action=like&font=arial&colorscheme=light&height=80", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

  def flash_display
    response = ""
    flash.each do |name, msg|
      response = response + content_tag(:div, msg, :class => "alert")
    end
    flash.discard
    response
  end

  # check if user is the same as current_user
  def is_current_user(user)
    if user == current_user
      return true
    else
      return false
    end
  end

  # get profile foto url
  def get_profile_photo_url(photo)
    if photo != nil
      return photo.image.url(:thumb)
    else
      return 'user.png'
    end
  end

  def get_user_small_profile_photo_url(user)
    photo = user.profile_photo
    if photo != nil
      return photo.image.url(:small)
    else
      return 'Transparent.png'
    end
  end

  def get_normal_cover_photo_url(photo)
    if photo != nil
      return photo.image.url(:original)
    else
      return 'Transparent.png'
    end
  end

#  def get_possesive_pronoun(gender)
#    if gender == "Male"
#      return "his"
#    elsif gender == "Female"
#      return "her"
#    else
#      return "his/her"
#    end
#  end

  # get permission name
  def get_permission_name(permission)
    case permission
      when Footprint32::PRIVATE
        return "Private"
      when Footprint32::FRIENDS
        return "Friends"
      else
        return "Public"
      end
  end

  def get_privacy_icon(permission)
    case permission
      when Footprint32::PRIVATE
        return fa_icon("lock") #"priv-private.png"
      when Footprint32::FRIENDS
        return fa_icon("users") #"priv-friend.png"
      else
        return fa_icon("globe") #"priv-public.png"
      end
  end

  # statistics helpers

  # user with most reviews
  def top_reviewers
    User.order("reviews_count DESC").includes(:profile, :profile_photo).limit(8)
  end

  # user with most popular reviews
  def popular_reviewers
    User.limit(5).sort_by(&:total_votes).reverse
  end

  # most reviewed places
  def most_reviewed_places
    Place.order("reviews_count DESC").limit(8)
  end

  def most_reviewed_places_in_a_week
    Review.weekly_top_places.limit(8)
  end

  def top_reviewers_in_a_week
    Review.weekly_top_reviewers.limit(8)
  end

  # most liked places
  def most_popular_places
    Place.order("favorite_places_count DESC").limit(8)
  end

  # most visited places
  def most_visited_places
    Place.order("visited_places_count DESC").limit(5)
  end

  def share_with_facebook_url(opts)

    # Generates an url that will 'share with Facebook', and can includes title, url, summary, images without need of OG data.
    #
    # URL generate will be like
    # http://www.facebook.com/sharer.php?s=100&p[title]=We also do cookies&p[url]=http://www.wealsodocookies.com&p[images][0]=http://www.wealsodocookies.com/images/logo.jpg&p[summary]=Super developer company
    #
    # For this you'll need to pass the options as
    #
    # { :url     => "http://www.wealsodocookies.com",
    #   :title   => "We also do cookies",
    #   :images  => {0 => "http://imagelink"} # You can have multiple images here
    #   :summary => "My summary here"
    # }

    url = "http://www.facebook.com/sharer.php?s=100"

    parameters = []

    opts.each do |k,v|
      key = "p[#{k}]"

      if v.is_a? Hash
        v.each do |sk, sv|
          parameters << "#{key}[#{sk}]=#{sv}"
        end
      else
        parameters << "#{key}=#{v}"
      end

    end

    url + parameters.join("&")
  end

  def polymorphic_association_includes(association, includes_association_name, includes_by_type)
    includes_by_type.each_pair do |includes_association_type, includes|
      polymorphic_association_includes_for_type(association, includes_association_name, includes_association_type, includes)
    end
  end

  def polymorphic_association_includes_for_type(association, includes_association_name, includes_association_type, includes)
    id_attr = "#{includes_association_name}_id"
    type_attr = "#{includes_association_name}_type"

    items = association.select {|item| item[type_attr] == includes_association_type.to_s }
    item_ids = items.map {|item| item[id_attr] }
    items_with_includes = includes_association_type.where(id: item_ids).includes(includes).index_by(&:id)

    items.each do |parent|
      parent.send("#{includes_association_name}=", items_with_includes[parent[id_attr]])
    end
  end
end
