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
  def grade_grade_context_ident
    self.grade_grade_context.ident
  end

  def grade_matter_ident
    self.grade_matter.ident
  end

  def grade_student_ident
    self.grade_student.ident
  end

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

  def ident
    # mode debug, rajout de l'id
    if LOG.level==0
      ret="#{id}"
    else
      ret=""
    end
    ret+="#{grade_grade_context_ident}.#{grade_matter_ident}.#{grade_student_ident}.#{value}"
  end
end
