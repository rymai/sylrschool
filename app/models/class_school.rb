class ClassSchool < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_save :validity
  before_destroy :check_destroy
  validates_presence_of :name, :default_location_id, :nb_max_student
  validates_uniqueness_of :name
  belongs_to :default_location , class_name: 'Location'
  belongs_to :matter_duration
  has_many :students, :foreign_key=>:student_class_school_id
  has_many :teachings, :foreign_key=>:teaching_class_school_id
  # verifier le nombre d'eleves de la salle avant d'y associer la class
  def validity
    msg=""
    valid=true
    unless self.default_location.nil?
      if self.nb_max_student > self.default_location.location_nb_max_person
        msg="La salle est trop petite (#{self.default_location.location_nb_max_person}) !!"
      valid=false
      else
      end
    else
    end
    self.errors.add(:base, "Class school is not valid:#{msg}") unless valid
    valid
  end

  # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
      puts "******************* students.count=#{students.count}"
    if students.count > 0
      valid=false
      msg+=" There are #{students.count} students references"
    end
      puts "******************* teachings.count=#{teachings.count}"
    if teachings.count > 0
      valid=false
      msg+=" There are #{teachings.count} teachings references"
    end
      puts "******************* valid=#{valid}"
     puts "******************* msg=#{msg}"
    self.errors.add(:base, "Class school can't be destroyed:#{msg}") unless valid
    valid
  end
  
   # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if students.count > 0
      valid=false
    end
    if teachings.count > 0
      valid=false
      msg+=" There are #{teachings.count} teachings references"
    end
    self.errors.add(:base, "Class school can't be destroyed:#{msg}") unless valid
    valid
  end
end
