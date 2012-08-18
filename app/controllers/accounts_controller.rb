class AccountsController < ApplicationController

before_filter :require_user

  def index  
    @accounts = Account.includes(:company).all   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end
  
end