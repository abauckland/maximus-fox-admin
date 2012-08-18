class GuidenotesController < ApplicationController

before_filter :require_user

  def new

    @guidenote =Guidenote.new
    clauseref_array = Clauseref.where(:subsection_id => [170]).collect{|i| i.id}
    @clauses = Clause.where(:clauseref_id => clauseref_array)
  end
 
end
