class Element < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates :name, uniqueness: true
  validates_presence_of :name, :for_what
   
  def self.for_whats
    SYLR::C_ALL_ELEMENT_FOR_WHATS
   end
  
  
end
