class Api::V1::PasswordsController < Devise::PasswordsController

  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
                   
  respond_to :json
                   
  def create
    puts "---reset pswd--"
    @user = User.find_by_email(params['user']['email'])
    if @user.present?
      @user.send_reset_password_instructions
    render :status => 200,
           :json => { :success => true,
                      :info => "Reset instruction sent" }
    end
  end
  
end
