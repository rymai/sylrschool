class Student < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  
  has_and_belongs_to_many :responsible, join_table: :student_responsibles

end
