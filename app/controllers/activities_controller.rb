class ActivitiesController < ApplicationController
  # GET /txt4s
  # GET /txt4s.json
  
  def index   
    @users = User.includes(:licence, :company).order("licences.last_sign_in DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end  
  end
end
