class Teacher < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  belongs_to :matter
  belongs_to :grade_context
  #####has_and_belongs_to_many :notebook, join_table: :notebook_teachers
  has_and_belongs_to_many :matter, join_table: :teacher_matters
  
  has_many :notebook_teachers, :foreign_key=>:teacher_id
  has_many :teacher_matters, :foreign_key=>:teacher_id
  has_many :teachings, :foreign_key=>:teaching_teacher_id

end
