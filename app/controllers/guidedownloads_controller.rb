class GuidedownloadsController < ApplicationController

before_filter :require_user

 def index
    @guides = Guidepdf.includes(:guidedownloads).order('title')
 
    
 end 

 
end
