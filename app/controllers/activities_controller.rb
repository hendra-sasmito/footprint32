class ActivitiesController < ApplicationController

  def index
    @user = current_user
    activities = @user.activities.includes(:target).order("created_at DESC").page(params[:page]).per(20)
    polymorphic_association_includes activities, :target, {
      FavoritePlace => [:place],
      FavoriteCity => [:city],
      VisitedPlace => [:place],
      VisitedCity => [:city]
      #Photo => [:photo],
      #Review => [:review]
    }
    result = Hash.new
    result[:activities] = activities.as_json

    count = 0
    activities.each do |activity|

      case activity.activity_type
      when Activity::ADD_FAVORITE_CITY
        result[:activities][count][:city] = activity.target.city
      when Activity::ADD_VISITED_CITY
        result[:activities][count][:city] = activity.target.city
      when Activity::ADD_FAVORITE_PLACE
        result[:activities][count][:place] = activity.target.place
      when Activity::ADD_VISITED_PLACE
        result[:activities][count][:place] = activity.target.place
      when Activity::UPLOAD_PHOTO
        result[:activities][count][:photo] = activity.target
      when Activity::CREATE_REVIEW
        result[:activities][count][:review] = activity.target
      else
        
      end
      count = count + 1
    end
    respond_to do |format|
      format.json { render json: result }
    end
  end

  def show
    
  end
  
end
