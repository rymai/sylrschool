class MatterDuration < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name, :matter_duration_level_id, :value
  validates :name, uniqueness: true
  has_many :matters
  belongs_to :element
  def self.matter_durations_levels
    Element.all.where("for_what = 'matter_duration_level' ").to_a
  end
 def self.matter_durations_levels_names
    matter_durations_levels.map {|r| [r.name, r]}
  end

end
