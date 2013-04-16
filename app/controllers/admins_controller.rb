class AdminsController < ApplicationController
  # GET /txt4s
  # GET /txt4s.json
  def index
    @user = User.where(:id => 32).first      
    @companies = Company.all 
  end
  
  def change
    @user = User.where(:id => 32).first       
    @user.company_id = params[:id]
    @user.save
    
    redirect_to menu_path
  end     
   
end
