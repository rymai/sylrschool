class StudentResponsible < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_update :set_custo
  #validates_uniqueness_of :student_id,scope=:responsible_id
end
