class User < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def custo=(acusto)

  end
  def self.roles
    SYLR::C_ALL_ROLES
  end
end
