class ExportssController < ApplicationController

before_filter :require_user
layout "upload"



#download template in csv format
  def download
  
 #columns for csv are:
 #0 - section ref
 #1 - subsection ref  
 #2 - clausetype_id  
 #3 - clause  
 #4 - subclause  
 #5 - clausetitle text  
 #6 - clauseline  
 #7 - txt1 text  
 #8 - txt2 text
 #9 - txt3 text 
 #10 - txt4 text 
 #11 - txt5 text 
 #12 - txt6 text
 #13 - linetype  
  
    speclines = Specline.joins(:clause => [:clauseref]).where('project_id = ? AND clauserefs.subsection_id = ?', params[:project_id], params[:subsection_id]).order('clauserefs.clausetype_id, clauserefs.clause, clauserefs.subclause, clause_line')  
    
    #load CSV
    require 'csv'
    
    
    filename ="#{specline.clause.clauseref.subsection.section.ref << specline.clause.clauseref.subsection.ref}_template_#{Date.today.strftime('%d%b%y')}"
    csv_data = FasterCSV.generate do |csv|
      
      #set headers
      csv << ['section', 'subsection', 'clausetype', 'clause', 'subclause', 'clausetitle', 'clauseline', 'txt1', 'txt2', 'txt3', 'txt4', 'txt5', 'txt6', 'linetype_id']
      
      speclines.each do |specline| 
        
        line=[]

        #include full reference for each line
        line[0] = specline.clause.clauseref.subsection.section.ref
        line[1] = specline.clause.clauseref.subsection.ref
        line[2] = specline.clause.clauseref.clausetype_id
        line[3] = specline.clause.clauseref.clause
        line[4] = specline.clause.clauseref.subclause
        line[6] = specline.clauseline
    
        #only include text where it exists
        if [1,2].include?(specline.linetype)
            line[5] = specline.clause.clausetitle.text
        else
          if specline.txt1 != 1
             line[7] = specline.txt1.text
          end
          if specline.txt2 != 1
             line[8] = specline.txt2.text
          end
          if specline.txt3 != 1
            line[9] = specline.txt3.text
          end
          if specline.txt4 != 1
            line[10] = specline.txt4.text
          end
          if specline.txt5 != 1
            line[11] = specline.txt5.text
          end
          if specline.txt6 != 1
            line[12] = specline.txt6.text
          end      
        end
    
        line[13] = specline.linetype
                      
        csv << line     
      end 
    end
     
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  
  end

#end of class
end

