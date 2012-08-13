class AccountsController < ApplicationController

  def index  

    @accounts = Account.includes(:company).all
    
    @accounts.each do |account|
      

    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

end
