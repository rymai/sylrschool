class ClassSchool < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name, :default_location_id
  validates_uniqueness_of :name
  belongs_to :default_location , class_name: 'Location'
  belongs_to :matter_duration , class_name: 'MAtterDuration'
end
