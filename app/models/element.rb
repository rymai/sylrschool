class Element < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates :name, uniqueness: true
  validates_presence_of :name, :for_what
  has_many :responsibles, :foreign_key=>:type_id
  has_many :teaching_domains, :foreign_key=>:teaching_domain_id
  has_many :locations, :foreign_key=>:usage_id
  has_many :teaching_levels, :foreign_key=>:teaching_level_id
  has_many :matters, :foreign_key=>:matter_type_id
  
  def self.for_whats
    SYLR::C_ALL_ELEMENT_FOR_WHATS
   end
    # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if responsibles.count > 0
      valid=false
      msg+=" There are #{responsibles.count} responsibles references"
    end
    #if teaching_domains.count > 0
    #  valid=false
    #  msg+=" There are #{teaching_domains.count} teaching_domains references"
    #end
    if locations.count > 0
      valid=false
      msg+=" There are #{locations.count} locations references"
    end
    #if teaching_levels.count > 0
    #  valid=false
    #  msg+=" There are #{teaching_levels.count} teaching_levels references"
    #end
    if matters.count > 0
      valid=false
      msg+=" There are #{matters.count} matters references"
    end
     self.errors.add(:base, "Element can't be destroyed:#{msg}") unless valid
    valid
  end
  
end
