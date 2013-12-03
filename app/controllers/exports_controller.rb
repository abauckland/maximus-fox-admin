class ExportsController < ApplicationController

before_filter :require_user
layout "upload"



#download template in csv format
  def clausetype_4_download
  
    @clausetitles_by_ref = Clause.joins(:clauseref, :clausetitle, :speclines).where('speclines.project_id' => 2, 'clauserefs.clausetype_id' => 4, 'speclines.linetype_id' => [1,2]).order('clauserefs.clause, clauserefs.subclause')
    
    #load CSV
    require 'csv'      
   # filename =
    @clausetitle_export = CSV.generate do |csv|      
      @clausetitles_by_ref.each do |clausetitle|                            
        csv << [clausetitle.clause_code, clausetitle.clausetitle.text]   
      end 
    end     
    send_data @clausetitle_export, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=clausetype4.csv" 
  end

  def clausetype_5_download
  
    @clausetitles_by_ref = Clause.joins(:clausetitle, :speclines, :clauseref).where('speclines.project_id' => 2, 'clauserefs.clausetype_id' => 5, 'speclines.linetype_id' => [1,2]).order('clauserefs.clause, clauserefs.subclause')
    
    #load CSV
    require 'csv'      
   # filename =
    @clausetitle_export = CSV.generate do |csv|      
      @clausetitles_by_ref.each do |clausetitle|                            
        csv << [clausetitle.clause_code, clausetitle.clausetitle.text]   
      end 
    end     
    send_data @clausetitle_export, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=clausetype5.csv" 
  end
#end of class
end

