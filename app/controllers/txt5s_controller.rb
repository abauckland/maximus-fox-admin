class Txt5sController < ApplicationController
  # GET /txt5s
  # GET /txt5s.json
  def index
    
    speclines = Specline.all.collect{|i| i.txt5_id}.uniq
    changes = Change.all.collect{|i| i.txt5_id}.uniq
    txt5_id_array = Txt5.all.collect{|i| i.id}
    
    unused_txt5_id_array = txt5_id_array - changes - speclines

    @txt5s = Txt5.where(:id => unused_txt5_id_array)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @txt5s }
    end
  end

  # GET /txt5s/1
  # GET /txt5s/1.json
  def show
    @txt5 = Txt5.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @txt5 }
    end
  end

  # GET /txt5s/new
  # GET /txt5s/new.json
  def new
    @txt5 = Txt5.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @txt5 }
    end
  end

  # GET /txt5s/1/edit
  def edit
    @txt5 = Txt5.find(params[:id])
  end

  # POST /txt5s
  # POST /txt5s.json
  def create
    @txt5 = Txt5.new(params[:txt5])

    respond_to do |format|
      if @txt5.save
        format.html { redirect_to @txt5, notice: 'Txt5 was successfully created.' }
        format.json { render json: @txt5, status: :created, location: @txt5 }
      else
        format.html { render action: "new" }
        format.json { render json: @txt5.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /txt5s/1
  # PUT /txt5s/1.json
  def update
    @txt5 = Txt5.find(params[:id])

    respond_to do |format|
      if @txt5.update_attributes(params[:txt5])
        format.html { redirect_to @txt5, notice: 'Txt5 was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @txt5.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /txt5s/1
  # DELETE /txt5s/1.json
  def destroy
    @txt5 = Txt5.find(params[:id])
    @txt5.destroy

    respond_to do |format|
      format.html { redirect_to txt5s_url }
      format.json { head :ok }
    end
  end
end
