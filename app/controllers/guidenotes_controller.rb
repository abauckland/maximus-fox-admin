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
    @current_clause_id = params[:clause_id]
    
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
    
    @guidenote = Guidenote.new do |n|
      n.text = params[:guidenote][:text]
    end
    
    if @guidenote.save

      clause = Clause.where(:id => params[:clause_id]).first 
      clause.guidenote_id = @guidenote.id
      clause.save
 
      respond_to do |format|

        format.html {  redirect_to(:controller => 'clauses', :action => 'show', :id => params[:subsection_id], :project_id => params[:project_id], notice: 'Guidance Note was successfully created.') }
        format.json
      end
    else
      respond_to do |format|
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
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @current_clause = params[:clause_id]
    
    @guidenote = Guidenote.where(:id => params[:id]).first
    @guidenote.text = params[:guidenote][:text]
    
    if @guidenote.save
 
      respond_to do |format|

        format.html {  redirect_to(:controller => 'clauses', :action => 'show', :id => params[:subsection_id], :project_id => params[:project_id], notice: 'Guidance Note was successfully created.') }
        format.json
      end
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @guidenote.errors, status: :unprocessable_entity }
      end
    end     
  end 
  
  def single_edit
    @current_project_id = params[:project_id]
    @current_subsection_id = params[:subsection_id]
    @current_clause_id = params[:clause_id]
    
    @guidenote_clauses = Clause.where('guidenote_id = ? AND id != ?', params[:id], params[:clause_id])
    if @guidenote_clauses

        #create new guidenote and save
      @current_guidenote = Guidenote.where(:id => params[:id]).first
      @new_guidenote = Guidenote.new do |n|
        n.text = @current_guidenote.text
      end 
      @new_guidenote.save
      
      @clause = Clause.where(:id => params[:clause_id]).first
      @clause.guidenote_id = @new_guidenote.id
      @clause.save
      
      redirect_to(:action => 'edit', :id => @new_guidenote.id, :clause_id => @current_clause_id, :subsection_id => @current_subsection_id, :project_id => @current_project_id)
    else 
      redirect_to(:action => 'edit', :id => params[:id], :clause_id => @current_clause_id, :subsection_id => @current_subsection_id, :project_id => @current_project_id)          
    end      
  end
 
end
