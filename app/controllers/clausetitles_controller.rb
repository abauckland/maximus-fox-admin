class ClausetitlesController < ApplicationController

before_filter :require_user

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
