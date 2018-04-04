class Responsible < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name, :type_id,:person_status,  :firstname, :lastname, :email
  validates :name, uniqueness: true
  
  has_and_belongs_to_many :students, join_table: :student_responsibles
  belongs_to :type , class_name: 'Element'
  def self.responsible_types
    Element.all.where("for_what = 'responsible_type' ").to_a
  end
   def self.responsible_types_names
    responsible_types.map {|r| [r.name, r]}
  end
  
  def ident_long
    "#{name}.#{type.name}"
  end
  
end
