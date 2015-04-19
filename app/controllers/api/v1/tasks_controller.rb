# file: app/controllers/api/v1/tasks_controller.rb
class Api::V1::TasksController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
#  before_filter :authenticate_user!
  before_filter :authenticate_user_from_token!

  respond_to :json

  def index
    respond_to do |format|
      format.json { 
        render :text => '{
        "success":true,
        "info":"ok",
        "data":{
            "tasks":[
                      {"title":"Complete the app"},
                      {"title":"Complete the tutorial"}
                    ]
           }
        }'
      }
    end
  end
end