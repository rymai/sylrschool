class Element < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates :name, uniqueness: true
  validates_presence_of :name, :for_what
  has_many :matter_durations, :foreign_key=>:matter_duration_level_id
  has_many :responsibles, :foreign_key=>:type_id
  has_many :teachings, :foreign_key=>:teaching_domain_id
  has_many :location, :foreign_key=>:usage_id
  has_many :teachings, :foreign_key=>:teaching_level_id
  has_many :matters, :foreign_key=>:matter_type_id
  
  def self.for_whats
    SYLR::C_ALL_ELEMENT_FOR_WHATS
   end
  
  
end
