class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:retrieve]

  def retrieve
    object = params[:type]
    puts "------retrieve------"
    puts params[:type]
    puts params[:idn]
    puts ",,,,,,,,,,,,"

    if object == "Photo"
      @commentable = Photo.includes(:creator).find_by_id(params[:idn])
    elsif object == "Event"
      @commentable = Event.includes(:creator).find_by_id(params[:idn])
    end
    if !@commentable.nil?
      @comments = @commentable.comments.order('created_at DESC').page(params[:page]).per(4)
      puts @comments
    else
      @comments = []
    end
    
    respond_to do |format|
      format.js
    end
  end
  
  def show
    @comment = Comment.find_by_id(params[:id])
    if !@comment.nil?
      @commentable = @comment.commentable
    else
      flash[:notice] = t(:comment_not_found)
      return redirect_back_or_default()
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  def create
    @comment = current_user.comments.new
    @comment.content = params[:comment][:content]
    @comment.commentable_id = params[:comment][:commentable_id]
    @comment.commentable_type = params[:comment][:commentable_type]

    @commentable = @comment.commentable
    @friend = @commentable.creator

    respond_to do |format|
      if @comment.save
        CommentsWorker.perform_async(current_user.id, @friend.id, @comment.id)
        format.html { redirect_to home_index_path, :notice => t(:comment_created) }
        format.json { render json: @comment, status: :created, location: @comment }
        format.js
      else
#        format.html { render action: "new" }
        format.html { redirect_back_or_default() }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @comment = current_user.comments.find_by_id(params[:id])
    if !@comment.nil?
      @commentable = @comment.commentable
    else
      flash[:error] = t(:comment_not_found)
      return redirect_back_or_default()
    end
  end

  def update
    @comment = current_user.comments.find_by_id(params[:id])
    if !@comment.nil?
      
#      if @comment.update_attributes(params[:comment])
#        flash[:notice] = "Successfully updated comment."
#        return redirect_back_or_default()
#      else
#        render :action => 'edit'
#      end
    else
      flash[:error] = t(:comment_not_found)
      return redirect_back_or_default()
    end

    respond_to do |format|
      if @comment.update_attributes(:content => params[:comment][:content])
        format.html { redirect_to comment_path(@comment), :notice => t(:comment_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @comment = current_user.comments.find_by_id(params[:id])
    if !@comment.nil?
      @commentable = @comment.commentable
      @comment.destroy
      flash[:notice] = t(:comment_deleted)
      if @commentable.class.name == "Event"
        return redirect_to user_event_path(@commentable.creator, @commentable)
      elsif @commentable.class.name == "Photo"
        return redirect_to user_photo_album_photo_path(@commentable.creator, @commentable.photo_album, @commentable)
      else
        return redirect_to home_index_path
      end
    else
      flash[:error] = t(:comment_not_found)
      return redirect_back_or_default()
    end
  end

  
end
