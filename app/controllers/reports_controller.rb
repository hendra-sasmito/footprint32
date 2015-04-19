class ReportsController < ApplicationController
  before_filter :authenticate_user_from_token!, :authenticate_user!

  def new
    @report = current_user.reports.new
    if params[:type] == "Photo"
      @reportable = Photo.find_by_id(params[:id])
    elsif params[:type] == "Place"
      @reportable = Place.find_by_id(params[:id])
    elsif params[:type] == "City"
      @reportable = City.find_by_id(params[:id])
    else
      return redirect_back_or_default
    end
    respond_to do |format|
      format.html { render :layout => !request.xhr? }
      format.js
    end
  end

  def create
    @report = current_user.reports.find_by_reportable_type_and_reportable_id_and_reason(params[:report][:reportable_type], params[:report][:reportable_id], params[:report][:reason])
    if !@report.nil?
      flash[:notice] = "You have reported this item"
    else
      @report = current_user.reports.new()
      @report.reportable_type = params[:report][:reportable_type]
      @report.reportable_id = params[:report][:reportable_id]
      @report.reason = params[:report][:reason]
      @report.comment = params[:report][:comment]
      if @report.save
        flash[:notice] = "Report was successfully sent"
      else
        flash[:notice] = "Can't report problem"
      end
    end

    respond_to do |format|
#      if @report.save
#        format.html { redirect_to review_path(@report), :notice => t(:report_created) }
#        format.json { render json: @report, status: :created, location: @report }
#        format.js
#      else
#        format.html { render action: "new" }
#        format.json { render json: @report.errors, status: :unprocessable_entity }
#      end
#      format.js
      format.html { redirect_back_or_default }
    end
  end

end
