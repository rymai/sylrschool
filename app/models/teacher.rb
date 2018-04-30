class Teacher < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  ########belongs_to :matter
  belongs_to :grade_context
  #####has_and_belongs_to_many :notebook, join_table: :notebook_teachers
  has_and_belongs_to_many :matters, join_table: :teacher_matters

  ###has_many :notebook_teachers, :foreign_key=>:teacher_id
  ###has_many :teacher_matters, :foreign_key=>:teacher_id
  has_many :teachings, :foreign_key=>:teaching_teacher_id
  # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if matters.count > 0
      valid=false
      msg+=" There are #{matters.count} teacher_matters references"
    end
    if teachings.count > 0
      valid=false
      msg+=" There are #{teachings.count} teachings references"
    end
    self.errors.add(:base, "Teacher can't be destroyed:#{msg}") unless valid
    valid
  end
# renvoie les horaires d'un professeur
  def get_schedules
    ret=[]
    #puts "==============teachings=#{self.teachings.to_a}"
    self.teachings.to_a.each do |teaching|
      teaching.schedules.each do |schedule|
        ret << schedule
      end
    end
    ret
  end
  #renvoie les classes d'un professeur
  def get_class_schools
    ret=[]
    self.teachings.to_a.each do |teaching|
      ret<< teaching.teaching_class_school
    end
    #puts "========================== teacher.get_class_schools: #{ret.count}"
    ret
  end
  # renvoie les etudiants d'un professeur
  def get_students
    ret=[]
    self.get_class_schools.each do |classe|
      ret.concat classe.students
    end
    #puts "========================== teacher.get_students: #{ret.count}"
   ret
  end
    # update the custo field of the relational object teacher_matter after save or update
  # appelle par le controleur teacher
  def update_custo_in_teacher_matter(ids)
    #puts "=============ids=#{ids}"
    unless ids.nil?
    ids.each do |id|
        unless id.blank?
          objrel=TeacherMatter.where("matter_id=#{id} and teacher_id=#{self.id}").to_a[0]
          objrel.destroy!
          objrel=TeacherMatter.create!({matter_id: id, teacher_id: self.id, custo: SYLR::V_APP_CUSTO})  
       end
      end
    end
  end
end
