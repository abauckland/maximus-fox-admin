class ClausetitlesController < ApplicationController
  # GET /clausetitles
  # GET /clausetitles.json
  def index
    
    used_clausetitle_id_array = Clause.all.collect{|i| i.clausetitle_id}.uniq
    clausetitle_id_array = Clausetitle.all.collect{|i| i.id}.uniq    
    
    unused_clausetitle_id_array = clausetitle_id_array - used_clausetitle_id_array

    @clausetitles = Clausetitle.includes(:clauses).where(:id => unused_clausetitle_id_array)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clausetitles }
    end
  end

  # GET /clausetitles/1
  # GET /clausetitles/1.json
  def show
    @clausetitle = Clausetitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clausetitle }
    end
  end

  # GET /clausetitles/new
  # GET /clausetitles/new.json
  def new
    @clausetitle = Clausetitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clausetitle }
    end
  end

  # GET /clausetitles/1/edit
  def edit
    @clausetitle = Clausetitle.find(params[:id])
  end

  # POST /clausetitles
  # POST /clausetitles.json
  def create
    @clausetitle = Clausetitle.new(params[:clausetitle])

    respond_to do |format|
      if @clausetitle.save
        format.html { redirect_to @clausetitle, notice: 'clausetitle was successfully created.' }
        format.json { render json: @clausetitle, status: :created, location: @clausetitle }
      else
        format.html { render action: "new" }
        format.json { render json: @clausetitle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clausetitles/1
  # PUT /clausetitles/1.json
  def update
    @clausetitle = Clausetitle.find(params[:id])

    respond_to do |format|
      if @clausetitle.update_attributes(params[:clausetitle])
        format.html { redirect_to @clausetitle, notice: 'clausetitle was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @clausetitle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clausetitles/1
  # DELETE /clausetitles/1.json
  def destroy
    @clausetitle = Clausetitle.find(params[:id])
    @clausetitle.destroy

    respond_to do |format|
      format.html { redirect_to clausetitles_url }
      format.json { head :ok }
    end
  end
end
