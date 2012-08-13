class Txt4sController < ApplicationController
  # GET /txt4s
  # GET /txt4s.json
  def index
    
    speclines = Specline.all.collect{|i| i.txt4_id}.uniq
    changes = Change.all.collect{|i| i.txt4_id}.uniq
    txt4_id_array = Txt4.all.collect{|i| i.id}
    
    unused_txt4_id_array = txt4_id_array - changes - speclines

    @txt4s = Txt4.where(:id => unused_txt4_id_array)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @txt4s }
    end
  end

  # GET /txt4s/1
  # GET /txt4s/1.json
  def show
    @txt4 = Txt4.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @txt4 }
    end
  end

  # GET /txt4s/new
  # GET /txt4s/new.json
  def new
    @txt4 = Txt4.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @txt4 }
    end
  end

  # GET /txt4s/1/edit
  def edit
    @txt4 = Txt4.find(params[:id])
  end

  # POST /txt4s
  # POST /txt4s.json
  def create
    @txt4 = Txt4.new(params[:txt4])

    respond_to do |format|
      if @txt4.save
        format.html { redirect_to @txt4, notice: 'Txt4 was successfully created.' }
        format.json { render json: @txt4, status: :created, location: @txt4 }
      else
        format.html { render action: "new" }
        format.json { render json: @txt4.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /txt4s/1
  # PUT /txt4s/1.json
  def update
    @txt4 = Txt4.find(params[:id])

    respond_to do |format|
      if @txt4.update_attributes(params[:txt4])
        format.html { redirect_to @txt4, notice: 'Txt4 was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @txt4.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /txt4s/1
  # DELETE /txt4s/1.json
  def destroy
    @txt4 = Txt4.find(params[:id])
    @txt4.destroy

    respond_to do |format|
      format.html { redirect_to txt4s_url }
      format.json { head :ok }
    end
  end
end
