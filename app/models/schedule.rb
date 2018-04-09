class Schedule < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  validates_presence_of :schedule_type, :start_time
  #before_save :validity
  belongs_to :schedule_father, :class_name=>Schedule
  belongs_to :schedule_teaching, :class_name=>Teaching

  has_many :presents, :foreign_key=>:schedule_id
  has_many :schedules, :foreign_key=>:schedule_father_id
  def self. schedule_types
    SYLR::C_ALL_SCHEDULE_TYPES
  end

  # renvoi les schedules all day , qui ne sont pas relie a un enseignement
  def self.get_only_all_day
    Schedule.all.where("schedule_teaching_id = NULL ")
  end

  # for start_time and duration depending of all_of_day
  def validity
    fname = "#{self.class.name}.#{__method__}"
    begin
      valid=true
      if start_time.nil?
        valid=false
        msg="The start_time can't be blank "
      end
      if all_of_day == false
        if duration.nil?
          valid=false
          msg="The duration can't be blank "
        end
      else
      # if all_of_day==true, duration is not usefull
        duration=nil
        # if all_of_day==true, hour and minute must be equals to 0
        self.start_time=self.start_time.change(hour:0,minute:0,second:0)
      end
      errors.add(:base, "Schedule is not valid:#{msg}") unless valid
    rescue Exception => e
      valid = false
      msg = 'Exception during schedule validity:'
      msg += "<br/>exception=#{e}"
      errors.add(:base, msg)
    end
    LOG.debug(fname) { "validity '#{self}' =#{valid} msg=#{msg}" }

    valid
  end

  # cree les we de l'annee si le type est weekend C_SCHEDULE_WEEKEND
  def create_calendar(schedule_params)
    ret=true
    if schedule_params[:schedule_type]==SYLR::C_SCHEDULE_WEEKEND
      if destroy_weekends
        # on cherche les dates de debut et fin de l'annee
        msg=""
        datet_debut=Element.get_calendar_begin
        if datet_debut.blank?
          msg+=" Pas de date debut ou mal formattée dans Element"
        ret=false
        end
        datet_fin=Element.get_calendar_end
        if datet_fin.blank?
          msg+=" Pas de date fin ou mal formattée dans Element"
        ret=false
        end
        puts "****************************** ret=#{ret}, msg=#{msg} "
        if ret
          #on cherche le 1er samedi apres la date de debut de l'annee
          # 0=dimanche 1 = lundi, samedi=6 ***
          num=datet_debut.wday
          datet_samedi_debut=datet_debut + (6-num).day

          #on cherche le dernier samedi avant la date de fin de l'annee
          num=datet_fin.wday
          if(num==6)
          datet_samedi_fin=datet_fin
          else
          datet_samedi_fin=datet_fin-(num+1).day
          end
          # on cree les samedi et dimanche entre les deux dates
          datet_current=datet_samedi_debut
          puts "****************************** datet_current=#{datet_current}"
          puts "****************************** datet_samedi_fin=#{datet_samedi_fin}"
          while ret && datet_current<datet_samedi_fin
            # creation samedi
            params=schedule_params
            params["start_time(1i)"]="#{datet_current.year}"
            params["start_time(2i)"]="#{datet_current.month}"
            params["start_time(3i)"]="#{datet_current.day}"
            puts "****************************** params sam=#{params}"
            schedule_sam=Schedule.new(params)

            unless schedule_sam.save
              msg="Saturday Schedule can't be saved"
            ret=false
            end
            # creation dimanche
            datet=datet_current+1.day
            params["start_time(1i)"]="#{datet.year}"
            params["start_time(2i)"]="#{datet.month}"
            params["start_time(3i)"]="#{datet.day}"
            puts "****************************** params dim=#{params}"
            schedule_dim=Schedule.new(params)
            unless schedule_dim.save
              msg="Sunday Schedule can't be saved"
            ret=false
            end
            datet_current+=7.day
          end

        end
      else
        ret=false
        msg="Pb. during destroying schedules"
      end
      unless ret
        self.errors.add(:base, "ScheduleS could not been destroyed :#{msg}")
      end
    else
    # save du schedule autre que we
    self.save
    end
    ret
  end

  # detruit
  def destroy_weekends
    ret=true
    msg=""
    Schedule.all.where("schedule_type='#{SYLR::C_SCHEDULE_WEEKEND}'").each do |schedule|
      unless schedule.destroy
        msg+=" Schedule #{schedule.ident_long} can't be detroyed"
      ret=false
      end
    end
    unless ret
      self.errors.add(:base, "ScheduleS could not been destroyed :#{msg}")
    end
    ret
  end

  # verifie la non presence de references
  def check_destroy
    valid=true
    msg=""
    if presents.count > 0
      valid=false
      msg+=" There are #{presents.count} presents references"
    end
    if schedules.count > 0
      valid=false
      msg+=" There are #{schedules.count} schedules references"
    end
    self.errors.add(:base, "Location can't be destroyed:#{msg}") unless valid
    valid
  end

  # for calendar of teaching for example
  def ident
    ret=""
    ret+="#{schedule_teaching.name}." unless schedule_teaching.nil?
    ret+="#{start_time_hour}."
    unless self.schedule_teaching.nil?
      ret+="#{self.schedule_teaching.teaching_matter.matter_duration}"
    else
      ret+="day"
    end
  end

  # for show view
  def ident_long
    ret=""
    ret+="#{schedule_teaching.name}." unless schedule_teaching.nil?
    ret+="#{start_time_date}."
    unless self.schedule_teaching.nil?
      ret+="#{self.schedule_teaching.teaching_matter.matter_duration}"
    else
      ret+="day"
    end
  end

  #enleve UTC... a la fin
  def start_time_date
    start_time.to_s[0,start_time.to_s.size-7]
  end

  # ne garde que l'heure et les minutes
  def start_time_hour
    "#{start_time.hour}:#{start_time.min}"
  end

  def is_root?
    self.schedule_father=self
  end

  # return true if this meeting is alone, no childs
  def is_alone?
    self.schedule_father=nil
  end

  # return the childs schedules of the current one
  # same object and father different meeting (in this case, it is the root itself)
  def get_childs
    ret=[]
    Schedule.all.where("father_father_id = '#{self.id}'").to_a.each do |schedule|
      ret << schedule if(schedule!=self)
    end
    ret
  end

end
