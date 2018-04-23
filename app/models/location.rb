class Location < ActiveRecord::Base
  include Models::CommonModels
  before_destroy :check_destroy
  before_save :set_custo
  validates_presence_of :name, :usage_id
  validates :name, uniqueness: true
  belongs_to :usage , class_name: 'Element'
  #has_one :class_school, :foreign_key=>:default_location_id
  has_many :teachings, :foreign_key=>:teaching_location_id
  def self.location_usages
    Element.all.where("for_what = 'location_usage' ").to_a
  end

  def self.location_usages_names
    location_usages.map {|r| [r.name, r]}
  end

  # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    unless teachings.count>0
      valid=false
      msg+=" There are teachings references"
    end
    self.errors.add(:base, "Location can't be destroyed:#{msg}") unless valid
    valid
  end

end
