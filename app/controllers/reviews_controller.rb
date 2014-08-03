class ReviewsController < ApplicationController
  helper :Places
  
  before_filter :authenticate_user!
  
  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.includes(:reviewable).find_by_id(params[:id])
    if @review.nil?
      flash[:notice] = t(:review_not_found)
      return redirect_back_or_default()
    else
      if (@review.reviewable.photos.public_photo.count > 0)
        @reviewable_photo = @review.reviewable.photos.public_photo.last
      else
        @reviewable_photo = nil
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = current_user.reviews.new
    1.times { @review.review_photos.build }
    @place = Place.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = current_user.reviews.find_by_id(params[:id])
    if @review.nil?
      flash[:notice] = t(:review_not_found)
      return redirect_back_or_default()
    else
      @reviewable = @review.reviewable
    end
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = current_user.reviews.new #(params[:review])
    @review.creator_id = current_user.id
    @review.content = params[:review][:content]
    @review.reviewable_id = params[:review][:reviewable_id]
    @review.reviewable_type = params[:review][:reviewable_type]
#    @review.creator_id = params[:creator_id]
#    @review.place_id = params[:place_id] if params[:place_id]

    shared = false
    share = current_user.shares.find_by_provider("facebook")
    if !share.nil?
      if share.share_review == true
        shared = true
      end
    end
    
    respond_to do |format|
      if @review.save
        if shared
          @content = @review.content
          @link = review_url(@review) #"http://www.koedok.com" #
          @name = "www.koedok.com"
          @user = current_user
#          graph.put_wall_post(content, {:name => name, :link => link})
          FbshareWorker.perform_async(@user.id, @content, @name, @link)
#          FbshareWorker.perform_async(token, content, name, link)
#          graph.put_wall_post("home", {:name => "place1", :link => "http://www.koedok.com"})
          #graph.put_wall_post("home", {:name => "place1", :link => review_path(@review)})
        end
        if false #disabled, not working with fb share
        @activity = Activity.create!(:user_id => @review.creator.id, :activity_type => Activity::CREATE_REVIEW, :target_type => @review.class.name, :target_id => @review.id)
        end
#        @activity = Activity.add(@review.creator, Activity::CREATE_REVIEW, @review, @review)
#        PrivatePub.publish_to("/reviews/new", "alert('#{@review.content}');")
        #PrivatePub.publish_to("/reviews/new", "eval('#{@review.content}');")
        format.html { redirect_to review_path(@review), :notice => t(:review_created) }
        format.json { render json: @review, status: :created, location: @review }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = current_user.reviews.find_by_id(params[:id])
    if @review.nil?
      flash[:notice] = t(:review_not_found)
      return redirect_back_or_default()
    else
      @reviewable = @review.reviewable
      @review.content = params[:review][:content]
      @review.reviewable_id = params[:review][:reviewable_id]
      @review.reviewable_type = params[:review][:reviewable_type]
    end

    respond_to do |format|
      #if @review.update_attributes(params[:review])
      if @review.save
        format.html { redirect_to review_path(@review), :notice => t(:review_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = current_user.reviews.find_by_id(params[:id])    
    if @review.nil?
      flash[:notice] = t(:review_not_found)
      return redirect_back_or_default()
    else
      @reviewable = @review.reviewable
      @review.destroy
    end

    respond_to do |format|
      if @reviewable.class.to_s == "Place"
        format.html { redirect_to place_url(@reviewable.id) }
      else
        format.html { redirect_to city_url(@reviewable.id) }
      end
      format.json { head :no_content }
    end
  end

  def vote
#    vote = current_user.review_votes.new(value: params[:value], review_id: params[:id])
    vote = current_user.review_votes.find_by_review_id(params[:id])
    if !vote.nil?
      if vote.value != params[:value]
        vote.value = params[:value]
        if vote.save
          redirect_to :back, notice: t(:voted)
        else
          redirect_to :back, alert: t(:voted_fail)
        end
      else
        redirect_to :back
      end
    else
      vote = current_user.review_votes.new()
      vote.value = params[:value]
      vote.review_id = params[:id]
      if vote.save
        redirect_to :back, notice: t(:voted)
      else
        redirect_to :back, alert: t(:voted_fail)
      end
    end
  end


end
