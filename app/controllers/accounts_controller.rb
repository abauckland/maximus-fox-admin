class AccountsController < ApplicationController

before_filter :require_user

  def index  
    @accounts = Account.includes(:company).all   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def add_licence
    @account = Account.where(:id => params[:id]).first
    @account.no_licence = @account.no_licence + 1
    @account.save
    
    redirect_to accounts_path
  end

  def minus_licence
    @account = Account.where(:id => params[:id]).first
  
    active_licences = Licence.joins(:user).where('users.company_id' => @account.company_id, :active_licence => 1).count
    if active_licences != @account.no_licence
      @account.no_licence = @account.no_licence - 1
      @account.save     
    end
    
    redirect_to accounts_path
end

  
end