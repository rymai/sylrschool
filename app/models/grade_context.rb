class GradeContext < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates :name, uniqueness: true
  validates_presence_of :name, :goal, :min_value, :max_value

  has_many :teachers, :foreign_key=>:defgradecontext_id
  has_many :grades, :foreign_key=>:grade_grade_context_id

end
