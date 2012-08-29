class ClausesController < ApplicationController

before_filter :require_user

  def show
   @current_project_id = params[:project_id]
   @current_subsection_id = params[:id]
   @clauses = Clause.joins(:clauseref, :speclines).where('clauserefs.subsection_id' => params[:id], 'speclines.project_id' => params[:project_id]).order('clauserefs.clausetype_id, clauserefs.clause, clauserefs.subclause').uniq
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subsections }
    end
  end
  
  def show_guide
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @clause = Clause.includes(:guidenote).where(:id => params[:id]).first
    
    @guidenote_clauses = Clause.where('guidenote_id = ? AND id != ?', @clause.guidenote_id, params[:id])
  end
  
  def delete_guidenote
    @clause = Clause.includes(:guidenote).where(:id => params[:id]).first
    @clause.guidenote_id = 1
    @clause.save
    redirect_to(:action => 'show', :id => params[:subsection_id], :project_id => params[:project_id]) 
    
  end
 
  
  def clone_subsection
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]    
    @current_clause_id = params[:id]
    project_subsection_ids = Subsection.joins(:clauserefs => [{:clauses => :speclines}]).where('speclines.project_id' => @current_project_id).collect{|i| i.id}.uniq    
    @clone_subsections = Subsection.where(:id => project_subsection_ids)
  end
    
  def clone_clause
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]    
    @current_clause_id = params[:clause_id]
    @clone_clauses = Clause.includes(:clauseref,:speclines).where('clauserefs.subsection_id =? AND speclines.project_id=? AND guidenote_id !=?', params[:clone_subsection], @current_project_id, 1).order('clauserefs.clausetype_id, clauserefs.clause, clauserefs.subclause')

  end
  
  def edit_guidenote

    clause = Clause.where(:id => params[:clause_id]).first
      clause.guidenote_id = params[:id]

  
    respond_to do |format|
      if clause.save
     # format.html { redirect_to @post, notice: 'Post was successfully created.' }
     # format.json { render json: @post, status: :created, location: @post }
           
     # format.html # show.html.erb
    format.html {  redirect_to(:action => 'show', :id => params[:subsection_id], :project_id => params[:project_id], notice: 'Post was successfully created.') }
    format.json
    else
     # format.html # show.html.erb
     redirect_to(:action => 'show', :id => params[:subsection_id], :project_id => params[:project_id]) 
      
    end 
    
    end 
  end
  
 end