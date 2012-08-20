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

    @guidenote = Guidenote.new
    clauseref_array = Clauseref.where(:subsection_id => [170]).collect{|i| i.id}
    @clauses = Clause.where(:clauseref_id => clauseref_array)
  end
 
  def create

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
 
 
end
