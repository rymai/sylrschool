class StudentResponsible < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_uniqueness_of :student,scope=:responsible
end
