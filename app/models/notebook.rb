class Notebook < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :name
  validates :name, uniqueness: true
  #suivant les relations vers
  belongs_to :student
  has_and_belongs_to_many :teacher, join_table: :notebook_teachers

  has_many :notebook_teacher, :foreign_key=>:teacher_id

end
