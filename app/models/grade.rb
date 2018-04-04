class Grade < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_save :validity

  #suivant les attributs
  validates_presence_of :grade_grade_context_id, :grade_matter_id, :grade_student_id, :grade_date, :value

  #suivant les relations vers
  belongs_to :grade_grade_context,:class_name=>"GradeContext"
  belongs_to :grade_matter,:class_name=>"Matter"
  belongs_to :grade_student,:class_name=>"Student"
  # check value in range of grade context
  def validity
    fname = "#{self.class.name}.#{__method__}"
    begin
      valid=true
      if value.nil?
        valid=false
        msg="The value can't be blank "
      else
      vmin=self.grade_grade_context.min_value
      vmax=self.grade_grade_context.max_value
      if self.value<vmin || value>vmax
        valid=false
        msg="Value (#{self.value})is not in grade_context range (#{vmin}..#{vmax})"
      end
      end
      errors.add(:base, "Grade is not valid:#{msg}") if valid == false

    rescue Exception => e
      valid = false
      msg = 'Exception during grade validity:'
      msg += "<br/>exception=#{e}"
      errors.add(:base, msg)
    end
    LOG.debug(fname) { "grade '#{self}' =#{valid} msg=#{msg}" }

    valid
  end
end
