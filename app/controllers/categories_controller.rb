class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /categories
  # GET /categories.json
  def index
    # check main category
    if params[:cat]
      # show categories
      category = Category.find_by_id(params[:cat])
      if !category.nil?
        @categories = category.children
      else
        flash[:error] = t(:category_not_found)
        @categories = nil
      end
    else
      # show all categories
      @categories = Category.subcategory
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find_by_id(params[:id])
    if !@category.nil?
      if !current_user.location.nil?
        @current_place = current_user.location
        @places = @category.places.near([@current_place.latitude, @current_place.longitude], Footprint32::NEARBY_PLACE_DISTANCE).page(params[:page]).per(10)
      else
        @current_place = nil
        @places = @category.places.page(params[:page]).per(10)
      end
    else
      flash[:error] = t(:category_not_found)
      return redirect_back_or_default(categories_path)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
      format.js
    end
  end
end
