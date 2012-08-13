class TemplatesController < ApplicationController

  def new
    @projects = Project.where('company_id = ?', 1)
  end  
  
  
  def create

 
   @projects = Project.where('company_id = ?', 1)
   
  require 'csv'
  
  csv = CSV.read(params[:csv_file], {:headers => true, }) 

  @csv = csv

  @csv.each do |line| 
  
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

end
