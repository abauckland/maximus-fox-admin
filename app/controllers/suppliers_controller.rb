class SuppliersController < ApplicationController
  
before_filter :require_user

  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suppliers }
    end
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supplier }
    end
  end

  # GET /suppliers/new
  # GET /suppliers/new.json
  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier }
    end
  end

  # GET /suppliers/1/edit
  def edit
    @supplier = Supplier.find(params[:id])
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new do |n|
     n.company_name = params[:supplier][:company_name]
     n.www = params[:supplier][:www]
     n.photo = params[:supplier][:photo]
    end

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render json: @supplier, status: :created, location: @supplier }
      else
        format.html { render action: "new" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suppliers/1
  # PUT /suppliers/1.json
  def update
    @supplier = Supplier.find(params[:id])
     @supplier.company_name = params[:supplier][:company_name]
     @supplier.www = params[:supplier][:www]
     @supplier.photo = params[:supplier][:photo]
     
    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to suppliers_url }
      format.json { head :ok }
    end
  end
end
