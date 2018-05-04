class Student < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  before_save :validity
  before_update :validity
  validates_presence_of :name,:person_status, :firstname, :lastname, :email,:notebook
  validates_uniqueness_of :name
  belongs_to :student_class_school,:class_name=>"ClassSchool"
  has_and_belongs_to_many :responsibles, join_table: :student_responsibles

  #has_many :student_responsibles, :foreign_key=>:student_id
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

  # get the teachers of the student
  def get_teachers
    ret=[]
    classe=self.student_class_school
    teachings=classe.teachings.to_a
    teachings.each do |teaching|
      ret << teaching.teaching_teacher
    end
    ret
  end
 # get locations used by the student
  def get_teachings
    classe=self.student_class_school
    classe.teachings.to_a
  end
  # get locations used by the student
  def get_locations
    ret=[]
    classe=self.student_class_school
    teachings=classe.teachings.to_a
    teachings.each do |teaching|
      ret << teaching.teaching_location unless ret.include? teaching.teaching_location
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

  def get_schedules
    ret=[]
    self.student_class_school.teachings.to_a.each do |teaching|
      teaching.schedules.each do |schedule|
        ret << schedule
      end
    end
    ret
  end

  # update the custo field of the relational object student_responsibles after save or update
  # appelle par le controleur student
  def update_custo_in_student_responsible(ids)
    puts "=============ids=#{ids}"
    unless ids.nil?
    ids.each do |id|
        unless id.blank?
          objrel=StudentResponsible.where("student_id=#{self.id} and responsible_id=#{id}").to_a[0]
          objrel.destroy!
          objrel=StudentResponsible.create!({student_id: self.id, responsible_id: id, custo: SYLR::V_APP_CUSTO})  
       end
      end
    end
  end
  
  # pour h_table student => class_chool
  def student_class_school_ident
    student_class_school.ident
  end
  
 

end
