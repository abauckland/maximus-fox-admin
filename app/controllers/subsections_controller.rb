class SubsectionsController < ApplicationController

before_filter :require_user

  def show
    @current_project_id = params[:id]
    project_subsection_ids = Subsection.joins(:clauserefs => [{:clauses => :speclines}]).where('speclines.project_id' => params[:id]).collect{|i| i.id}.uniq    
    @subsections = Subsection.where(:id => project_subsection_ids)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subsections }
    end
  end
  
end
 