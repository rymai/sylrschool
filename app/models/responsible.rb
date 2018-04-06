class Responsible < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates_presence_of :name, :type_id,:person_status,  :firstname, :lastname, :email
  validates :name, uniqueness: true
  
  has_and_belongs_to_many :students, join_table: :student_responsibles
  belongs_to :type , class_name: 'Element'
    
  has_many :student_responsibles, :foreign_key=>:responsible_id

  def self.responsible_types
    Element.all.where("for_what = 'responsible_type' ").to_a
  end
   def self.responsible_types_names
    responsible_types.map {|r| [r.name, r]}
  end
  
    # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if student_responsibles.count > 0
      valid=false
      msg+=" There are #{student_responsibles.count} student_responsibles references"
    end
    self.errors.add(:base, "Responsible can't be destroyed:#{msg}") unless valid
    valid
  end

  def ident_long
    "#{name}.#{type.name}"
  end
  
  
end
