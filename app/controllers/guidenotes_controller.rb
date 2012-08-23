class GuidenotesController < ApplicationController

before_filter :require_user

  def show
    @guidenote = Guidenote.find(params[:id])
    @clauses = Clause.where(:guidenote_id => @guidenote.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guidenote }
    end
  end



  def new
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @current_clause = params[:clause_id]
    
    @clauses = Clause.joins(:clauseref, :speclines).where('speclines.project_id' => @current_project_id, 'clauserefs.subsection_id' => @current_subsection_id).uniq
    @guidenote = Guidenote.new
           
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guidenote }
    end
  end
  
  
  def create
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @current_clause = params[:clause_id]
    
    @guidenote = Guidenote.create(params[:guidenote])

    clause = Clause.where(:id => params[:id]).first 
    clause.guidenote_id = @guidenote.id
    clause.save
 
        respond_to do |format|
      if @post.save
        format.html { redirect_to @guidenote, notice: 'Guidance Note was successfully created.' }
        format.json { render json: @guidenote, status: :created, location: @guidenote }
      else
        format.html { render action: "new" }
        format.json { render json: @guidenote.errors, status: :unprocessable_entity }
      end
    end      
 end 
  
  def edit
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @current_clause = params[:clause_id]
    @clause = Clause.where(:id => params[:clause_id]).first
    @guidenote = Guidenote.where(:id => params[:id]).first   
  end
  
  def update
    
  end 
 
end
