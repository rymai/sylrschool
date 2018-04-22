class Session < ActiveRecord::Base
  before_save :set_custo
  attr_accessor :role,:name
  def role=(role)
    @role = role
    puts "**********==========********role=#{@role}"
    role
  end

  def role
    puts "**********===========********role:=#{@role}"
    @role
  end
end
