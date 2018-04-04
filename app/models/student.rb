class Student < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  belongs_to :student_class_school,:class_name=>"ClassSchool"
  has_and_belongs_to_many :responsible, join_table: :student_responsibles

end
