class Location < ActiveRecord::Base
  include Models::CommonModels
  before_destroy :check_destroy
  before_save :set_custo
  validates_presence_of :name, :usage_id
  validates :name, uniqueness: true
  belongs_to :usage , class_name: 'Element'
  has_many :class_schools, :foreign_key=>:default_location_id
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
    if class_schools.count > 0
      valid=false
      msg+=" There are #{class_schools.count} class schools references"
    end
    self.errors.add(:base, "Location can't be destroyed:#{msg}") unless valid
    valid
  end

end
