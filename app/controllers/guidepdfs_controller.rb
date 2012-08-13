class GuidepdfsController < ApplicationController

#before_filter :require_use

#layout "application"

 def menu
   
 end

 def new
   @guidepdf = Guidepdf.new
   @subsections = Subsection.includes(:section).order('id') 
   
 end 
 
 def create
   @guidepdf = Guidepdf.new(params[:guidepdf])
   @guidepdf.save
   
  subsection = Subsection.where(:id => params[:guidepdf][:id]).first
  subsetion.guidepdf_id = @guidepdf.id
  subsection.save
  
 end 
 
end
