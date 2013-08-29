class StandardsController < ApplicationController

  def new
    @standard = Standard.new
  end  
  
  def create  

    #csv import template layout
      #line[0] = reference
      #line[1] = part
      #line[2] = title
      #line[3] = year
      #line[4] = classification
      #line[5] = Class

    require 'csv'
  
    @csv = CSV.read(params[:file].path)   
    headers = @csv[0]
    
    @csv_no_headers = @csv.drop(1)    
    
    if @csv_no_headers

      @csv_no_headers.each_with_index do |line, i| 
      #create performance pair

        #find or create Txt3
        txt3_check = Txt3.find_or_create_by_text(line[4])

        #find or create Txt3units
        txt3units_check = Txt3unit.where(:txt3_id => txt3_check.id, :unit_id => nil).first
        if txt3units_check.blank?
          txt3units_check = Txt3.create(:txt3_id => txt3_check.id)
        end

        #find or create Txt6
        txt6_check = Txt6.find_or_create_by_text(line[5])

        #find or create performance pair
        performance_check = Performance.where(:txt3unit_id => txt3units_check, :txt6_id => txt6_check).first
        if performance_check.blank?
          performance_check = Performance.create(:txt3unit_id => txt3units_check, :txt6_id => txt6_check)       
        end

      #create standard record
        standard_hash = {:ref => line[0], :part => line[1], :title => line[2], :year => line[3]}
        standard = Standard.where(standard_hash).first
        if standard.blank?
          standard = Standard.create(standard_hash)
        end
        
      #create standard performance associations
        standardperformance_check = Standardperformance.where(:standard_id => standard.id, :performance_id => performance_check.id).first 
        if standardperformance_check.blank?
          standardperformance_check = Standardperformance.create(:standard_id => standard.id, :performance_id => performance_check.id) 
        end
      end      
    end        
  end


  def upload_standard_subsection 

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
