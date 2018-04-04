class Teacher < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name,:person_status, :firstname, :lastname, :email
  validates :name, uniqueness: true
  belongs_to :matter
  belongs_to :grade_context
  has_and_belongs_to_many :notebook, join_table: :notebook_teachers
  has_and_belongs_to_many :matter, join_table: :teacher_matters
end
