class Student < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  before_save :validity
  before_update :validity
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  belongs_to :student_class_school,:class_name=>"ClassSchool"
  has_and_belongs_to_many :responsible, join_table: :student_responsibles

  has_many :student_responsibles, :foreign_key=>:student_id
  has_many :presents, :foreign_key=>:student_id
  has_many :grades, :foreign_key=>:grade_student_id
  has_one :notebook, :foreign_key=>:student_id
  # verifier le nombre d'eleves de la classe avant d'y inscrire l'etudiant
  def validity
    msg=""
    valid=true
    unless self.student_class_school.nil?
      nb_in_class=self.student_class_school.students.count
      if nb_in_class >= self.student_class_school.nb_max_student
        msg="La classe est pleine !!"
      valid=false
      end
    end
    self.errors.add(:base, "Student is not valid:#{msg}") unless valid
    valid
  end

  def teachers
    ret=[]
    classe=self.student_class_school
    teachings=classe.teachings.to_a
    teachings.each do |teaching|
      ret << teaching.teaching_teacher
    end
    ret
  end
  
    # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if student_responsibles.count > 0
      valid=false
      msg+=" There are #{student_responsibles.count} student_responsibles references"
    end
    if presents.count > 0
      valid=false
      msg+=" There are #{presents.count} presents references"
    end
    if grades.count > 0
      valid=false
      msg+=" There are #{grades.count} grades references"
    end
    unless notebook.nil?
      valid=false
      msg+=" There are one notebooks references"
    end
 
    self.errors.add(:base, "Student can't be destroyed:#{msg}") unless valid
    valid
  end


end
