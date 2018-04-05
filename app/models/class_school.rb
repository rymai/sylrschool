class ClassSchool < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_save :validity
  validates_presence_of :name, :default_location_id
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
end
