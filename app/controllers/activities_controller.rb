class ActivitiesController < ApplicationController

  before_filter :authenticate_user_from_token!, :authenticate_user!
  
  def index
    result = Hash.new
    if params[:user_id]
      @user = User.find_by_id(params[:user_id])
    else
      @user = current_user
    end
    if !@user.nil?
      activities = @user.activities.includes(:target).order("created_at DESC").page(params[:page]).per(20)
      polymorphic_association_includes activities, :target, {
        FavoritePlace => [:place],
        FavoriteCity => [:city],
        VisitedPlace => [:place],
        VisitedCity => [:city]
        #Photo => [:photo],
        #Review => [:review]
      }
      result[:activities] = activities.as_json
      count = 0
      activities.each do |activity|

        case activity.activity_type
#        when Activity::ADD_FAVORITE_CITY
#          result[:activities][count][:city] = activity.target.city
        when Activity::ADD_VISITED_CITY
          result[:activities][count][:city] = activity.target.city
        when Activity::ADD_FAVORITE_PLACE
          result[:activities][count][:place] = activity.target.place
#        when Activity::ADD_VISITED_PLACE
#          result[:activities][count][:place] = activity.target.place
#        when Activity::UPLOAD_PHOTO
#          result[:activities][count][:photo] = activity.target
#        when Activity::CREATE_REVIEW
#          result[:activities][count][:review] = activity.target
        else

        end
        count = count + 1
      end
    else
      result[:activities] = []
    end
    
    respond_to do |format|
      format.json { render json: result }
    end
  end

  def show
    
  end
  
end
