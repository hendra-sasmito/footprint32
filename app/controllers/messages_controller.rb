class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /messages
  # GET /messages.xml
  def index

#    search = current_user.messages.solr_search do #(:include => [:sender]) do
#      fulltext params[:search]
#      paginate :page => params[:page], :per_page => 10
#    end
#
#    @messages = search.results

#    @messages = current_user.messages.includes(:users => [:profile, :profile_photo]).page(params[:page]).per(10)

    @message_statuses = current_user.message_statuses.undeleted.includes(:message => [:users => [:profile, :profile_photo]]).page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @message_statuses }
      format.js
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    puts "############ messages show ###############"
    @message = current_user.messages.find_by_id(params[:id])
    if !@message.nil?
      @conversations = @message.conversations.includes(:sender => [:profile, :profile_photo])

      @message_status = @message.message_statuses.find_by_user_id(current_user)
      latest_conversation = @message_status.start_at
      if @message_status.start_at == nil
        @conversations = @message.conversations.includes(:sender => [:profile, :profile_photo])
      else
        @conversations = @message.conversations.where("id > ?", latest_conversation).includes(:sender => [:profile, :profile_photo])
      end
      if !@message_status.nil?
        if @message_status.status == MessageStatus::UNREAD
          @message_status.status = MessageStatus::READ
          @message_status.save!
        end
      else
        flash[:error] = "Message is not found"
        return redirect_to messages_path
      end
      @reply_conversation = Conversation.new
      @reply_conversation.content = nil
    else
      flash[:error] = "Message is not found"
      return redirect_to messages_path
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  def unread
    puts "############ messages mark_as_unread ###############"
    @message = current_user.messages.find_by_id(params[:id], :readonly => false)
    if !@message.nil?
      @message_status = @message.message_statuses.find_by_user_id(current_user)
      if !@message_status.nil?
        @message_status.status = MessageStatus::UNREAD
        @message_status.save!
        return redirect_to messages_path
      else
        flash[:error] = "Message is not found"
        return redirect_to messages_path
      end
    else
      flash[:error] = "Message is not found"
      return redirect_to messages_path
    end

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    puts "---new message ---"
    if params[:recv]
      @recv = params[:recv]
      @user_recv = User.find_by_id(@recv)
    else
      @recv = nil
    end
    puts @recv
    @message = current_user.messages.new
    @conversation = @message.conversations.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
#  def edit
#    @message = current_user.messages.find_by_id(params[:id])
#    if !@message.nil?
#      @conversations = @message.conversations
#    else
#      flash[:error] = "Message is not found"
#      return redirect_to messages_path
#    end
#  end

  # POST /messages
  # POST /messages.xml
  def create
    puts "########## messages create #############"
    recipients = params[:user_ids].split(',')
    puts recipients
    recipient_ids = recipients.collect{|i| i.to_i}
    
    @message = current_user.messages.new
    @message.subject = params[:message][:subject]
    if !@message.save
      flash[:notice] = 'Can not sent message.'
      return render :action => "new"
    end

    @conversation = @message.conversations.new
    @conversation.sender = current_user
    @conversation.content = params[:message][:conversation][:content]

    respond_to do |format|
      if @conversation.save
        MessageStatus.associate_user(@message, current_user, recipient_ids)
        format.html { redirect_to(messages_path, :notice => 'Message was successfully sent.') }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
#  def update
#    @message = current_user.messages.find_by_id(params[:id])
#    if @message.nil?
#      flash[:error] = "Message is not found"
#      return redirect_to messages_path
#    end
#    respond_to do |format|
#      if @message.update_attributes(params[:message])
#        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    puts "######### MessageController destroy ###########"
    @message = current_user.messages.find_by_id(params[:id], :readonly => false)
    if !@message.nil?
      @message_status = @message.message_statuses.find_by_user_id(current_user)
      if !@message_status.nil?
        @message_status.status = MessageStatus::DELETED
        @message_status.start_at = @message.conversations.last.id
        @message_status.save!
      end
    else
      flash[:error] = "Message is not found"
      return redirect_to messages_path
    end

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end

#  def auto_complete_for_friend_name
#    search = params[:user][:name]
#    @users = User.find(:all, :conditions => ["full_name LIKE ?", "%#{search}%"])
#    render :partial => 'autocomplete'
#  end

  def get_recipient
    search = User.solr_search(:include => [:profile]) do
      fulltext params[:q]
    end
    users = search.results

    recipients = Array.new
    for i in 0..(users.count - 1)
       recipients[i] = Hash.new
       recipients[i][:id] = users[i].id
       recipients[i][:name] = users[i].profile.full_name
    end
    recipients.uniq!
    render :json => recipients.to_json
  end

  def reply
    puts "######### MessageController reply ###########"
      @message = current_user.messages.find_by_id(params[:message_id], :readonly => false)
      if @message.nil?
        flash[:error] = "Message is not found"
#        redirect_to :controller => 'messages', :action => 'index'
        return
      end
      @message.updated_at = Time.now

      @new_conversation = @message.conversations.new
      @new_conversation.sender = current_user
      @new_conversation.content = params[:message_content]

      if @new_conversation.save and @message.save
        @message_statuses = @message.find_message_statuses
        @message_statuses.each do |message_status|
        if message_status.user != current_user
          if message_status.status != MessageStatus::UNREAD
            message_status.status = MessageStatus::UNREAD
            message_status.save!
          end
        else
          message_status.status = MessageStatus::SENT
          message_status.save!
        end
        flash[:notice] = "Message sent."
      end  
    end
  end

  def search
    search = MessageStatus.solr_search(:include => [:message => [:users => [:profile, :profile_photo]]]) do
      fulltext params[:search]
      with(:user_id).equal_to(current_user.id)
      paginate :page => params[:page], :per_page => 10
    end

    @message_statuses = search.results
    puts "--------search--------"
    puts @message_statuses
#    for ms in @message_statuses
#      if ms.user_id != current_user.id
#        @message_statuses.delete_at(@message_statuses.index(ms))
#      end
#    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @message_statuses }
      format.js
    end
  end
end
