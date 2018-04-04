class Session < ActiveRecord::Base
  before_save :set_custo
end
