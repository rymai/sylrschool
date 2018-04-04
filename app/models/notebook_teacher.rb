class NotebookTeacher < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_uniqueness_of :notebook,scope=:teacher
end
