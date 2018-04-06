class GradeContext < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates :name, uniqueness: true
  validates_presence_of :name, :goal, :min_value, :max_value

  ########has_many :teachers, :foreign_key=>:defgradecontext_id
  has_many :grades, :foreign_key=>:grade_grade_context_id

 # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
     if grades.count > 0
      valid=false
      msg+=" There are #{grades.count} teachings references"
    end
    self.errors.add(:base, "Grade context can't be destroyed:#{msg}") unless valid
    valid
  end
end
