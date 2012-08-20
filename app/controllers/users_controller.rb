class UsersController < ApplicationController
  # GET /txt4s
  # GET /txt4s.json
  def index   
    @users = User.includes(:licence, :company).where('licences.locked_at' => 1)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def unlock
    @licence = Licence.where('user_id =?', params[:id]).first    
    @licence.locked_at = 0
    @licence.save

    redirect_to users_path
  
  end 
   
end
