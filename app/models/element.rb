class Element < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates :name, uniqueness: true
  validates_presence_of :name, :for_what
  has_many :responsibles, :foreign_key=>:type_id
  has_many :teaching_domains, :foreign_key=>:teaching_domain_id
  has_many :locations, :foreign_key=>:usage_id
  has_many :teaching_levels, :foreign_key=>:teaching_level_id
  has_many :matters, :foreign_key=>:matter_type_id
  def self.for_whats
    SYLR::C_ALL_ELEMENT_FOR_WHATS
  end

  # renvoie la date du debut de l'annee scolaire
  def self.get_calendar_begin
    # annee/mois/jour
    get_calendar_date("calendar_begin")
  end

  def self.get_calendar_end
    # annee/mois/jour
    get_calendar_date("calendar_end")
  end

  # renvoie la date du debut de l'annee scolaire
  # annee/mois/jour
  def self.get_calendar_date(param)
    fname= "#{self.class.name}.#{__method__}"
    # annee/mois/jour
    elements=Element.all.where("for_what = '#{param}' ").to_a
    puts "*********************************** elements.size=#{elements.size}"
    if(elements.size>=1)
      begin
        str=elements[0].name
        ret=str.to_datetime
      rescue :exception=>e
        LOG.error(fname){"Error on getting date in Element (#{e.full_messages}"}
        ret=""
      end
    else
      ret=""
    end
    ret
  end

  # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if responsibles.count > 0
      valid=false
      msg+=" There are #{responsibles.count} responsibles references"
    end
    #if teaching_domains.count > 0
    #  valid=false
    #  msg+=" There are #{teaching_domains.count} teaching_domains references"
    #end
    if locations.count > 0
      valid=false
      msg+=" There are #{locations.count} locations references"
    end
    #if teaching_levels.count > 0
    #  valid=false
    #  msg+=" There are #{teaching_levels.count} teaching_levels references"
    #end
    if matters.count > 0
      valid=false
      msg+=" There are #{matters.count} matters references"
    end
    self.errors.add(:base, "Element can't be destroyed:#{msg}") unless valid
    valid
  end

end
