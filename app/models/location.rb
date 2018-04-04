class Location < ActiveRecord::Base
  include Models::CommonModels
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

end
