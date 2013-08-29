class StandardsubsectionsController < ApplicationController

  def new
    @standardsubsection = Standardsubsection.new
  end  
  
  def create   

    #csv import template layout
      #line[0] = reference
      #line[1] = part
      #line[3] = year
      #line[4] = section
      #line[5] = subsection

    require 'csv'
  
    @csv = CSV.read(params[:file].path)   
    headers = @csv[0]
    
    @csv_no_headers = @csv.drop(1)    
    
    if @csv_no_headers

      @csv_no_headers.each_with_index do |line, i| 
        
        standard = Standard.where(:ref => line[0], :part => line[1], :year => line[2]).first
        if standard
          subsection = Subsection.joins(:section).where('sections.ref' => line[4], :ref => line[5]).first
        
          standardsubsection_check = Standardsubsection.where(:txt3unit_id => txt3units_check, :txt6_id => txt6_check).first
          if standardsubsection_check.blank?
            standardsubsection_check = Standardsubsection.create(:txt3unit_id => txt3units_check, :txt6_id => txt6_check)       
          end                    
        end

      end      
    end        
  end
    
end
