class GuidepdfsController < ApplicationController

before_filter :require_user

 def new
    @guidepdf = Guidepdf.new
    @subsections = Subsection.includes(:section).order('id')   
 end 
 
 def create
   
    subsection = Subsection.where(:id => params[:id]).first
   
    @guidepdf = Guidepdf.new(params[:guidepdf])
    @guidepdf.title = subsection.subsection_full_code_and_title
    @guidepdf.save
     
    subsection.guidepdf_id = @guidepdf.id
    subsection.save
 
    redirect_to(menu_path)  
 end 
 
end
