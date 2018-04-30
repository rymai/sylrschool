class Schedule < ActiveRecord::Base
  include Models::CommonModels
  before_save :set_custo
  before_destroy :check_destroy
  attr_accessor :nb_repetition
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
    ret=Schedule.all.where("schedule_teaching_id = #{SYLR::C_INDIC_DAY_SCHEDULE}").to_a
    #puts "====================schedule.get_only_all_day=#{ret.count} ret=#{ret}"
  end

  def self.get_not_all_day
    Schedule.all.where("schedule_teaching_id <> #{SYLR::C_INDIC_DAY_SCHEDULE}").to_a
  end

  # pour la view h_table
  def schedule_father_ident
    schedule_father.ident
  end

  def schedule_teaching_ident
    schedule_teaching.ident
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
  # depuis la valeur de Element:calendar_begin jusqu'a Element:calendar.end
  # cree les jours de vacance de l'annee si le type est weekend C_SCHEDULE_WEEKEND
  def create_calendar(schedule_params)
    ret=true
    puts "create_calendar params#{schedule_params}"
    if schedule_params[:schedule_type]==SYLR::C_SCHEDULE_WEEKEND
      if destroy_weekends
        # on cherche les dates de debut et fin de l'annee
        msg=""
        datet_debut=self.start_time
        datet_fin=datet_debut+(self.nb_repetition.to_i.week)
        #puts "****************************** datet_debut=#{datet_debut}, nb_repetition=#{nb_repetition}, datet_fin=#{datet_fin} "
        #puts "****************************** ret=#{ret}, msg=#{msg} "
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
          #puts "****************************** datet_current=#{datet_current}"
          #puts "****************************** datet_samedi_fin=#{datet_samedi_fin}"
          while ret && datet_current<=datet_samedi_fin
            # creation samedi
            params=schedule_params
            params["start_time(1i)"]="#{datet_current.year}"
            params["start_time(2i)"]="#{datet_current.month}"
            params["start_time(3i)"]="#{datet_current.day}"
            params["schedule_teaching_id"]=SYLR::C_INDIC_DAY_SCHEDULE
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
            params["schedule_teaching_id"]=SYLR::C_INDIC_DAY_SCHEDULE
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
    elsif schedule_params[:schedule_type]==SYLR::C_SCHEDULE_HOLIDAY
      #creation des jours de vacances, le user les cree periode par periode, on s'occupe ici d'une periode de vacances
      # a partir du start_time , repete nb_repetition fois en sautant les we deja crees
      # limite, les modifs a faire seront manuelles si on modifie ensuite les we
      #
      ind=0
      datet_current=self.start_time
      father=nil
      #puts "****************************** debut de #{self.nb_repetition} repetitions"
      while ind < self.nb_repetition.to_i && ret
        wday=datet_current.wday
        #puts "****************************** ind=#{ind}" wday=#{wday}"
        # on saute les samedi et dimanche , on peut "surcharger" des jours feries ou pont ou non travailles
        if wday != 0 && wday != 6
          params=schedule_params
          params["start_time(1i)"]="#{datet_current.year}"
          params["start_time(2i)"]="#{datet_current.month}"
          params["start_time(3i)"]="#{datet_current.day}"
          params["schedule_teaching_id"]="SYLR::C_INDIC_DAY_SCHEDULE"
          # puts "****************************** params=#{params}"
          schedule=Schedule.new(params)
          if ind==0
            father=schedule
          end
          schedule.schedule_father=father
          unless schedule.save
            msg="Holiday Schedule can't be saved"
          ret=false
          end
        ind+=1
        end
        # recherche de la date suivante
        datet_current+=1.day
      end
    else
    # save du schedule autre que we et holiday
    self.schedule_teaching_id=SYLR::C_INDIC_DAY_SCHEDULE
    self.save
    end
    ret
  end

  # destruction d'un ou
  # plusieurs si il est root et de type holiday, on detruit alors ses fils aussi
  def destroy_schedule
    ret=true
    if self.is_root? &&  self.schedule_type==SYLR::C_SCHEDULE_HOLIDAY
      self.get_childs.each do |child|
        ret=child.destroy if ret
      end
    ret=self.destroy
    else
    ret=self.destroy
    end
    ret
  end

  # detruit tous les week-end
  def destroy_weekends
    ret=true
    msg=""
    weekends=Schedule.all.where("schedule_type='#{SYLR::C_SCHEDULE_WEEKEND}'").to_a
    weekends.each do |schedule|
      unless schedule.destroy
       msg+=" Schedule #{schedule.ident_long} can't be destroyed"
       puts "========================= schedule.destroy_weekends : error:#{msg}\n"
       ret=false
      end
    end
    unless ret
      self.errors.add(:base, "ScheduleS could not been destroyed :#{msg}")
    end
    ret
  end

  # verifie la non presence de references: sur les presences et sur les horaires (lien vers le root)
  # on pourra cependant detruire le root malgre qu'il se reference lui meme
  def check_destroy
    valid=true
    msg=""
    if presents.count > 0
      valid=false
      msg+=" There are #{presents.count} presents references"
    end
    if schedules.count > 0 && !self.is_root?
      valid=false
      msg+=" There are #{schedules.count} schedules references"
    end
    unless valid
      errormsg="Schedule can't be destroyed:#{msg}"
      puts "========= errormsg=#{errormsg}"
      self.errors.add(:base, errormsg)
    end
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
      ret="day:#{self.schedule_type}"
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
    Schedule.all.where("schedule_father_id = '#{self.id}'").to_a.each do |schedule|
      ret << schedule if(schedule!=self)
    end
    ret
  end

end
