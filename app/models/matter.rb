class Matter < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  validates_presence_of :matter_duration_id
  validates_presence_of :name
  validates_presence_of :matter_type_id
  validates_presence_of :matter_nb_max_student
  validates :name, uniqueness: true
  belongs_to :matter_type , class_name: 'Element'
  belongs_to :matter_duration
  has_and_belongs_to_many :teacher, join_table: :teacher_matters
  #
  def self.matter_types
    Element.all.where("for_what = 'matter_type' ").to_a
  end

  def get_all
    all.to_a
  end
end
