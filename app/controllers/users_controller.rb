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
  
  def activity    
    @users = User.includes(:licence, :company).all.order('licences.last_sign_in')    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end  
  end
  
  def access   
    @companies = Company.all 
  end
  
  def update_access
    @user = User.where(:id => 35).first       
    @user.company_id = params[:id]
    @user.save
  end     
   
end
