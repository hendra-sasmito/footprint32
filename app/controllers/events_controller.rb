class EventsController < ApplicationController
  before_filter :authenticate_user_from_token!, :authenticate_user!, :except => [:show, :monthly_events]
  
  # GET /events
  # GET /events.json
  def index
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      past = params[:past]
      if (past == Event::PAST_EVENT)
        @events = get_past_events(@user).page(params[:page]).per(10)
      else
        @events = get_events(@user).page(params[:page]).per(10)
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
      format.js
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      @event = @user.events.includes({:place => [:category, {:city => [:region, :country]}]}).find_by_id(params[:id])
      if @event.nil?
        flash[:error] = t(:event_not_found)
        return redirect_back_or_default(user_events_path(@user))
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    if (is_user_allowed(@user, @event.privacy))
      @comment = Comment.new
      @comments = @event.comments.includes(:user => [:profile]).order("created_at DESC").page(params[:comment_page]).per(5)
      @commentable = @event
    else
      flash[:error] = t(:event_not_found)
      return redirect_back_or_default(user_events_path(@user))
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
      format.js
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    puts "----new-------"
    @user = User.find_by_id(params[:user_id])
    if params[:place_id]
      @place = Place.find_by_id(params[:place_id])
      if !@place.nil?
        @param_place_id = params[:place_id]
      else
        flash[:error] = t(:place_not_found)
        return redirect_back_or_default(user_events_path(@user))
      end
    end
    if !@user.nil?
      if is_current_user(@user)
        @event = @user.events.new
      else
        flash[:error] = t(:not_allowed)
        return redirect_back_or_default(user_events_path(@user))
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
#      format.html # new.html.erb
      format.html { render :layout => !request.xhr? }
      format.json { render json: @event }
      format.js
    end
  end

  # GET /events/1/edit
  def edit
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @event = @user.events.find_by_id(params[:id])
        if !@event.nil?
          
        else
          flash[:error] = t(:event_not_found)
          return redirect_back_or_default(user_events_path(@user))
        end
      else
        flash[:error] = t(:not_allowed)
        return redirect_back_or_default(user_events_path(@user))
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end
  end

  # POST /events
  # POST /events.json
  def create
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @event = current_user.events.new(params[:event])
#        @event = current_user.events.build(:name => params[:event][:name], :privacy =>
#          params[:event][:privacy], :description => params[:event][:description])
#        @event.date = DateTime.new(params[:event]["date1(1i)"].to_i,
#                        params[:event]["date1(2i)"].to_i,
#                        params[:event]["date1(3i)"].to_i,
#                        params[:event]["date1(4i)"].to_i,
#                        params[:event]["date1(5i)"].to_i)
#        puts "------------"
#        puts params[:event]
#        puts @event.name
#        puts @event.date
        if @event.date <= Time.zone.now
          flash[:error] = t(:date_not_valid)
          return render action: "new"
        end
        @event.place_id = params[:event][:place_id] if params[:event][:place_id]
        @event.privacy = params[:event][:privacy]

        shared = false
        share = current_user.shares.find_by_provider("facebook")
        if !share.nil?
          if share.share_event == true
            shared = true
          end
        end
      else
        flash[:error] = t(:not_allowed)
        return redirect_back_or_default( user_events_path(@user))
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      if @event.save
        if shared
          @content = @event.description
          @link = user_event_url(@user, @event)
          @name = "www.koedok.com"
          FbshareWorker.perform_async(@user.id, @content, @name, @link)
        end
        if false #disabled, not working with fb share
          @activity = Activity.create!(:user_id => @event.creator.id, :activity_type => Activity::CREATE_EVENT, :target_type => @event.class.name, :target_id => @event.id)
        end
        format.html { redirect_to user_event_path(@user, @event), :notice => t(:event_created) }
        format.json { render json: @event, status: :created, location: @event }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @event = current_user.events.find_by_id(params[:id])
        if @event.nil?
          flash[:error] = t(:event_not_found)
          return redirect_back_or_default( user_events_path(@user))
        end
        @event.place_id = params[:place_id] if params[:place_id]
      else
        flash[:error] = t(:not_allowed)
        return redirect_back_or_default(user_events_path(@user))
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      if @event.update_attributes(params[:event])
        if @event.date <= Time.zone.now
          flash[:error] = t(:date_not_valid)
          return render action: "edit"
        end
        format.html { redirect_to user_event_path(@user, @event), :notice => t(:event_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @user = User.find_by_id(params[:user_id])
    if !@user.nil?
      if is_current_user(@user)
        @event = current_user.events.find_by_id(params[:id])
        if @event.nil?
          flash[:error] = t(:event_not_found)
          return redirect_back_or_default(user_events_path(@user))
        else
          @event.destroy
        end
      else
        flash[:error] = t(:not_allowed)
        return redirect_back_or_default(user_events_path(@user))
      end
    else
      flash[:error] = t(:user_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      format.html { redirect_to user_events_url(@user) }
      format.json { head :no_content }
    end
  end

  def monthly_events
#    puts "---------monthly_events---------"
#    puts params[:year]
#    puts params[:month]
#    puts params[:id]
    if params[:id] and params[:type] == "City"
      city = City.find_by_id(params[:id])
      if !city.nil?
        date = params[:year] + "-" + params[:month] + "-01"
        events = city.events.includes(:place, :creator).by_month(date)

        @event_list = events.map do |u|
          image = view_context.place_small_photo(u.place)
          body_string = ""
          body_string += u.id.to_s + ";"
          body_string += u.name.to_s + ";"
          body_string += u.date.localtime.strftime("%d %b %Y %H:%S").to_s + ";"
          body_string += !u.description.nil? ? u.description.to_s + ";" : "" + ";"
          body_string += u.creator.profile.full_name.to_s + ";"
          body_string += u.place.name.to_s + ";"
          body_string += !u.place.street.nil? ? u.place.street.to_s + ";" : "" + ";"
          body_string += !u.place.city.nil? ? u.place.city.name.to_s + ";" : "" + ";"
          body_string += !u.place.city.region.nil? ? u.place.city.region.name.to_s + ";" : "" + ";"
          body_string += !u.place.city.country.nil? ? u.place.city.country.name.to_s + ";" : "" + ";"
          body_string += (user_event_url(u.creator.id, u.id)).to_s + ";"
          body_string += image.to_s + ";"
          body_string += current_user == u.creator ? (edit_user_event_url(u.creator.id, u.id)).to_s : ""
          {
            :date => u.date.strftime("%F"),
            :body => body_string,
            :classname => "purple-event"
          }
        end
      else
      end
    elsif params[:id] and params[:type] == "User"
      user = User.find_by_id(params[:id])
      if !user.nil?
        date = params[:year] + "-" + params[:month] + "-01"
        events = user.events.includes(:place, :creator).by_month(date)

        @event_list = events.map do |u|
          image = view_context.place_small_photo(u.place)
          body_string = ""
          body_string += u.id.to_s + ";"
          body_string += u.name.to_s + ";"
          body_string += u.date.localtime.strftime("%d %b %Y %H:%S").to_s + ";"
          body_string += !u.description.nil? ? u.description.to_s + ";" : "" + ";"
          body_string += u.creator.profile.full_name.to_s + ";"
          body_string += u.place.name.to_s + ";"
          body_string += !u.place.street.nil? ? u.place.street.to_s + ";" : "" + ";"
          body_string += !u.place.city.nil? ? u.place.city.name.to_s + ";" : "" + ";"
          body_string += !u.place.city.region.nil? ? u.place.city.region.name.to_s + ";" : "" + ";"
          body_string += !u.place.city.country.nil? ? u.place.city.country.name.to_s + ";" : "" + ";"
          body_string += (user_event_url(u.creator.id, u.id)).to_s + ";"
          body_string += image.to_s + ";"
          body_string += current_user == u.creator ? (edit_user_event_url(u.creator.id, u.id)).to_s : ""
          
          {
            :date => u.date.strftime("%F"),
            :body => body_string,
            :classname => "purple-event"
          }
        end
      else
      end
    elsif params[:id] and params[:type] == "Place"
      place = Place.find_by_id(params[:id])
      if !place.nil?
        date = params[:year] + "-" + params[:month] + "-01"
        events = place.events.includes(:place, :creator).by_month(date)

        @event_list = events.map do |u|
          image = view_context.place_small_photo(u.place)
          body_string = ""
          body_string += u.id.to_s + ";"
          body_string += u.name.to_s + ";"
          body_string += u.date.localtime.strftime("%d %b %Y %H:%S").to_s + ";"
          body_string += !u.description.nil? ? u.description.to_s + ";" : "" + ";"
          body_string += u.creator.profile.full_name.to_s + ";"
          body_string += u.place.name.to_s + ";"
          body_string += !u.place.street.nil? ? u.place.street.to_s + ";" : "" + ";"
          body_string += !u.place.city.nil? ? u.place.city.name.to_s + ";" : "" + ";"
          body_string += !u.place.city.region.nil? ? u.place.city.region.name.to_s + ";" : "" + ";"
          body_string += !u.place.city.country.nil? ? u.place.city.country.name.to_s + ";" : "" + ";"
          body_string += (user_event_url(u.creator.id, u.id)).to_s + ";"
          body_string += image.to_s + ";"
          body_string += current_user == u.creator ? (edit_user_event_url(u.creator.id, u.id)).to_s : ""
          
          {
            :date => u.date.strftime("%F"),
            :body => body_string,
            :classname => "purple-event"
          }
        end
        
      else
      end
    else
    end
    respond_to do |format|
      format.json { render json: @event_list }
    end
  end
  
  private

  def get_events(user)
    if (is_current_user(user) or Friendship.is_friend?(current_user, user))
      return @user.events.includes(:place).incoming_event
    else
      return @user.events.includes(:place).public_event.incoming_event
    end
  end

  def get_past_events(user)
    if (is_current_user(user) or Friendship.is_friend?(current_user, user))
      return @user.events.includes(:place).past_event
    else
      return @user.events.includes(:place).public_event.past_event
    end
  end

end
