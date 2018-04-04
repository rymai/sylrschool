class GradeContext < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
    validates :name, uniqueness: true
    validates_presence_of :name, :goal, :min_value, :max_value
end
