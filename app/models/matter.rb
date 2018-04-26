class Matter < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates_presence_of :matter_duration
  validates_presence_of :name
  validates_presence_of :matter_type_id
  validates_presence_of :matter_nb_max_student
  validates :name, uniqueness: true
  belongs_to :matter_type , class_name: 'Element'
  ####belongs_to :matter_duration
  has_and_belongs_to_many :teachers, join_table: :teacher_matters

  has_many :grades, :foreign_key=>:grade_matter_id
  ###has_many :teachers, :foreign_key=>:defmatter_id
  ###has_many :teacher_matters, :foreign_key=>:teacher_id
  #
  def self.matter_types
    Element.all.where("for_what = 'matter_type' ").to_a
  end

  def matter_type_ident
    matter_type.ident
  end
  def get_all
    all.to_a
  end

  # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if grades.count > 0
      valid=false
      msg+=" There are #{grades.count} grades references"
    end
    if teachers.count > 0
      valid=false
      msg+=" There are #{teachers.count} grades references"
    end
    if teacher_matters.count > 0
      valid=false
      msg+=" There are #{teacher_matters.count} teacher_matters references"
    end
    self.errors.add(:base, "Matter can't be destroyed:#{msg}") unless valid
    valid
  end
end
