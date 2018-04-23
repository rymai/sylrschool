class Session < ActiveRecord::Base
  before_save :set_custo
  attr_accessor :role,:name
  def role=(role)
    @role = role
  end

  def role
    @role
  end

  #renvoie la liste des time zone tries sur le nom ([[texte,nom]])
  def self.time_zones_inutilisee
    ret=ActiveSupport::TimeZone.all.sort_by(&:name).collect {|z| [ z.to_s, z.name ]}
    #puts "time_zones:" + ret.inspect
    ret
  end

  #renvoie le texte du fuseau horaire en fonction du code
  def v_time_zone_inutilisee
    @time_zone ||= (self.time_zone.blank? ? nil : ActiveSupport::TimeZone[self.time_zone])
  end
end
