class TemplatesController < ApplicationController

before_filter :require_user
layout "upload"

  def index
    @project_id = 13
    @subsections = Subsections.joins(:clauserefs => [:clauses => [:speclines]]).where('speclines.project_id = ?', @project_id).order('id')
  end
  


  def new
    @projects = Project.where('company_id = ?', 1)
    @template = Template.new

  end  
  

  
  def create
    
 #columns for csv are:
 #0 - section ref
 #1 - subsection ref  
 #2 - clausetype_id  
 #3 - clause  
 #4 - subclause  
 #5 - clausetitle text  
 #6 - clause line  
 #7 - txt1 text  
 #8 - txt2 text
 #9 - txt3 text 
 #10 - txt4 text 
 #11 - txt5 text 
 #12 - txt6 text
 #13 - linetype        

 #used for next view only
       @projects = Project.where('company_id = ?', 1)
   
  #load CSV
  CSV.foreach(params[:file].path, headers: true) do |row|
  
  #check clause
  #check clause title
    if !line[5].blank?
      clausetitle_check = Clausetitle.where('BINARY text =?', line[5]).first
      if clausetitle_check.blank?
        clausetitle_check = Clausetitle.create(:text => line[5])
        @clausetitle_id = clausetitle_check.id
      else
        @clausetitle_id = clausetitle_check.id
      end
      @clausetitle_id = 1
    end

    #check clause_ref
    @section = Section.where('ref =?', line[0]).first
    @subsection = Subsection.where(:section_id => @section.id, :ref => line[1]).first
    
    clauseref_check = Clauseref.where('subsection_id = ? AND clausetype_id = ? AND clause =? AND subclause = ?', @subsection.id, line[2], line[3], line[4]).first    
    if clauseref_check.blank?  
      @clauseref = Clauseref.new do |n|
        n.subsection_id = @subsection.id
        n.clausetype_id = line[2]
        n.clause = line[3]
        n.subclause = line[4]
      end
      @clauseref.save
    else
      @clauseref = clauseref_check
    end

      
    project = Project.where(:id => params[:selected_project]).first
    clause_check = Clause.where('clauseref_id = ? AND project_id = ? AND clausetitle_id = ?', @clauseref.id, project.id, @clausetitle_id).first
    if clause_check.blank? 
      @clause = Clause.new do |n|
        n.clauseref_id = @clauseref.id
        n.project_id = project.id
        n.clausetitle_id = @clausetitle_id
        n.guide_id = 1  
      end
      @clause.save
    else
      @clause = clause_check
    end
    
if [1,2].include?(line[13])    
    
  @txt1_id = 1
  @txt2_id = 1
  @txt3_id = 1
  @txt4_id = 1
  @txt5_id = 1
  @txt6_id = 1
  
else
#check text cells
#check txt1 cell and get id value
    if !line[7].blank?
      txt1_check = Txt1.where('BINARY text =?', line[7]).first
      if txt1_check.blank?
        txt1_check = Txt1.create(:text => line[7])
      end
      @txt1_id = txt1_check.id
    else
      @txt1_id = 1
    end
#check txt2 cell and get id value
    if !line[8].blank?
      txt2_check = Txt2.where('BINARY text =?', line[8]).first
      if txt2_check.blank?
        txt2_check = Txt2.create(:text => line[8])
      end
      @txt2_id = txt2_check.id
    else
      @txt2_id = 1
    end
#check txt3 cell and get id value
    if !line[9].blank?
      txt3_check = Txt3.where('BINARY text =?', line[9]).first
      if txt3_check.blank?
        txt3_check = Txt3.create(:text => line[9])
      end
      @txt3_id = txt3_check.id
    else
      @txt3_id = 1
    end
#check txt4 cell and get id value
    if !line[10].blank?
      txt4_check = Txt4.where('BINARY text =?', line[10]).first
      if txt4_check.blank?
        txt4_check = Txt4.create(:text => line[10])
      end
      @txt4_id = txt4_check.id
    else
      @txt4_id = 1
    end
    
###       
  #table = "Txt1"
   # field_check(table, line[7])
  #@txt1_id = @line_cell_id    
#def field_check(table, line_cell)
  #if !line_cell.blank?
 #     check = table.where('BINARY text =?', line_cell).first
 #     if check.blank?
  #      check = table.create(:text => line_cell)
  #    end
 #     @line_cell_id = check.id
 #   else
 #     @line_cell_id = 1
 #   end
#end   
###

#check txt5 cell and get id value
    if !line[11].blank?
      txt5_check = Txt5.where('BINARY text =?', line[11]).first
      if txt5_check.blank?
        txt5_check = Txt5.create(:text => line[11])
      end
      @txt5_id = txt5_check.id
    else
      @txt5_id = 1
    end
#check txt6 cell and get id value
    if !line[12].blank?
      txt6_check = Txt6.where('BINARY text =?', line[12]).first
      if txt6_check.blank?
        txt6_check = Txt6.create(:text => line[12])
      end
      @txt6_id = txt6_check.id
    else
      @txt6_id = 1
    end
    
end    
  
#check to see if line already exists - allows overrighting/update of current templates  
 specline_check = Specline.where(
      :project_id => params[:selected_project],
      :clause_id => @clause.id,
      :linetype_id => line[13],
      :txt1_id => @txt1_id,
      :txt2_id => @txt2_id,
      :txt3_id => @txt3_id,
      :txt4_id => @txt4_id,
      :txt5_id => @txt5_id,
      :txt6_id => @txt6_id
 ).first
 
  if !specline_check.blank?
    if specline_check.clause_line != line[6]
    #save with new clauseline reference?
      specline_check.clause_line = line[6]
      specline_check.save  
      #record change    
    end 
  else   
  #create new specline  
    @specline = Specline.new do |n|
      n.project_id = params[:selected_project]
      n.clause_id = @clause.id
      n.linetype_id = line[13]
      n.clause_line = line[6]
      n.txt1_id = @txt1_id
      n.txt2_id = @txt2_id
      n.txt3_id = @txt3_id
      n.txt4_id = @txt4_id
      n.txt5_id = @txt5_id
      n.txt6_id = @txt6_id
    end
    @specline.save
    #record change  
  end 
end

    respond_to do |format|

        format.html { render :action => "new" }

    end

end

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

