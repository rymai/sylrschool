class TeacherMatter < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_uniqueness_of :teacher,scope=:matter
end
