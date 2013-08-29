class Performance < ActiveRecord::Base
#associations
  has_many :characteristics
  has_many :standardperformances
  belongs_to :txt3unit
  belongs_to :txt6
end
