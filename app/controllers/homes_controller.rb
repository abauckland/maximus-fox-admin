class HomesController < ApplicationController

before_filter :require_user, :except => [:index]

  def index
   
  end

  def menu
    
  end

end
