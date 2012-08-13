class Txt3sController < ApplicationController
  # GET /txt3s
  # GET /txt3s.json
  def index
    
    speclines = Specline.all.collect{|i| i.txt3_id}.uniq
    changes = Change.all.collect{|i| i.txt3_id}.uniq
    txt3_id_array = Txt3.all.collect{|i| i.id}
    
    unused_txt3_id_array = txt3_id_array - changes - speclines

    @txts = Txt3.where(:id => unused_txt3_id_array)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @txt3s }
    end
  end

  # GET /txt3s/1
  # GET /txt3s/1.json
  def show
    @txt3 = Txt3.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @txt3 }
    end
  end

  # GET /txt3s/new
  # GET /txt3s/new.json
  def new
    @txt3 = Txt3.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @txt3 }
    end
  end

  # GET /txt3s/1/edit
  def edit
    @txt3 = Txt3.find(params[:id])
  end

  # POST /txt3s
  # POST /txt3s.json
  def create
    @txt3 = Txt3.new(params[:txt3])

    respond_to do |format|
      if @txt3.save
        format.html { redirect_to @txt3, notice: 'Txt3 was successfully created.' }
        format.json { render json: @txt3, status: :created, location: @txt3 }
      else
        format.html { render action: "new" }
        format.json { render json: @txt3.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /txt3s/1
  # PUT /txt3s/1.json
  def update
    @txt3 = Txt3.find(params[:id])

    respond_to do |format|
      if @txt3.update_attributes(params[:txt3])
        format.html { redirect_to @txt3, notice: 'Txt3 was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @txt3.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /txt3s/1
  # DELETE /txt3s/1.json
  def destroy
    @txt3 = Txt3.find(params[:id])
    @txt3.destroy

    respond_to do |format|
      format.html { redirect_to txt3s_url }
      format.json { head :ok }
    end
  end
end
