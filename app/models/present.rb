class Present < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo

  validates_presence_of :present_type, :student_id, :schedule_id, :teaching_id
 
  belongs_to :student
  belongs_to :schedule
  belongs_to :teaching
  
  def ident
    "#{id}"
  end
end
