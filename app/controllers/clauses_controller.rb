class ClausesController < ApplicationController

before_filter :require_user

  def show
   @current_project_id = params[:project_id]
   @current_subsection_id = params[:id]
    @clauses = Clause.joins(:clauseref, :speclines).where('clauserefs.subsection_id' => params[:id], 'speclines.project_id' => params[:project_id]).uniq
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subsections }
    end
  end
  
  def show_guide
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @clause = Clause.includes(:guidenote).where(:id => params[:id]).first
    
    @guidenote_clauses = Clause.where(:guidenote_id => @clause.guidenote_id)
  end
  
  def delete_guidenote
    @clause = Clause.includes(:guidenote).where(:id => params[:id]).first
    @clause.guidenote_id = 1
    @clause.save
    respond_to do |format|
      format.html # show.html.erb
      format.json { redirect_to(:action => 'show', :id => params[:subsection_id], :project_id => params[:project_id]) }
    end
  end
  
  def add_guide
    
  end
  
  def create
    
  end
  
 end