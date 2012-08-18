class HomesController < ApplicationController

before_filter :require_user, :except => [:log_in]

  def log_in
   
  end

  def menu
    
  end

end
