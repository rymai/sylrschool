class Student < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_save :validity
  before_update :validity
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  belongs_to :student_class_school,:class_name=>"ClassSchool"
  has_and_belongs_to_many :responsible, join_table: :student_responsibles

  has_many :student_responsibles, :foreign_key=>:student_id
  has_many :presents, :foreign_key=>:student_id
  has_many :grades, :foreign_key=>:grade_student_id
  has_many :notebook, :foreign_key=>:student_id
  # verifier le nombre d'eleves de la classe avant d'y inscrire l'etudiant
  def validity
    msg=""
    valid=true
    unless self.student_class_school.nil?
      nb_in_class=self.student_class_school.students.count
      if nb_in_class >= self.student_class_school.nb_max_student
        msg="La classe est pleine !!"
      valid=false
      else
      end
    else

    end
    self.errors.add(:base, "Student is not valid:#{msg}") unless valid
    valid
  end

end
