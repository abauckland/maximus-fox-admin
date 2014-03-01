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
    send_data @clausetitle_export, :type => 'text/csv', :disposition => "attachment; filename=clausetype4.csv" 
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
    send_data @clausetitle_export, :type => 'text/csv', :disposition => "attachment; filename=clausetype5.csv" 
  end
  
  def linetype_change
    
    projects = Specline.all.collect{|i| i.project_id}.uniq.sort 
    
projects.each do |project|    
    
    speclines = Specline.where(:project_id => project, :linetype_id => [5, 6])
    
    speclines.each do |line|
            
      txt3 = Txt3.where(:id => line.txt3_id).first
        
      txt4_exist = Txt4.where(:text => txt3.text).first    
      if txt4_exist.blank?
         new_txt4_text = Txt4.create(:text => txt3.text)
      else
         new_txt4_text = txt4_exist
      end

      if line.txt6_id != 1
        txt6 = Txt6.where(:id => line.txt6_id).first
        
        txt5_exist = Txt5.where(:text => txt6.text).first    
        if txt5_exist.blank?
          new_txt5_text = Txt5.create(:text => txt6.text)
        else
          new_txt5_text = txt5_exist
        end                
      line.txt5_id = new_txt5_text.id
      line.txt6_id = 1  
      end      
      
        
      line.txt4_id = new_txt4_text.id
      line.txt3_id = 1
      line.linetype_id = 8

      line.save                 
    
    end    
end

###run changes on changes table
  changes = Change.where(:linetype_id => 5)
    changes.each do |line|
      txt3 = Txt3.where(:id => line.txt3_id).first
        
      txt4_exist = Txt4.where(:text => txt3.text).first    
      if txt4_exist.blank?
         new_txt4_text = Txt4.create(:text => txt3.text)
      else
         new_txt4_text = txt4_exist
      end
      
      txt6 = Txt6.where(:id => line.txt6_id).first
        
        txt5_exist = Txt5.where(:text => txt6.text).first    
        if txt5_exist.blank?
          new_txt5_text = Txt5.create(:text => txt6.text)
        else
          new_txt5_text = txt5_exist
        end                
      
      line.txt5_id = new_txt5_text.id
      line.txt6_id = 1            
      line.txt4_id = new_txt4_text.id
      line.txt3_id = 1
      line.linetype_id = 8
      line.save     
    end

  changes = Change.where(:linetype_id => 6)
    changes.each do |line|
      txt3 = Txt3.where(:id => line.txt3_id).first
        
      txt4_exist = Txt4.where(:text => txt3.text).first    
      if txt4_exist.blank?
         new_txt4_text = Txt4.create(:text => txt3.text)
      else
         new_txt4_text = txt4_exist
      end
      line.txt4_id = new_txt4_text.id
      line.txt3_id = 1
      line.linetype_id = 8
      line.save       
    end


  end
  
  def clausetype_update
    
    clausetypes = [2, 3, 4, 5, 6]
    clausetypes.each do |type|
      clauserefs = Clauseref.where(:clausetype_id => type)
      
      clauseref.each do |ref|
        type.to_i
        ref.clausetype_id = type + 1
        ref.save
      end      
    end    
  end
#end of class
end

