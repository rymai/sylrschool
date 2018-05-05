class MainController < ApplicationController
  # GET /mains
  # GET /mains.json

  skip_before_action :authenticate_user!
  # pour eviter une boucle sur index
  skip_before_action :check_action_for_role
  def index
    @datas=get_datas_count
  end

  def show
  end

  def tools
    @languages=SYLR::C_ALL_LANGUAGES
    @themes=SYLR::C_ALL_THEMES
  end

  def index_actions
    fname = "#{self.class.name}.#{__method__}"
    ret=[]
    get_controllers_classes().each do |controller|
      ret << get_actions_of_controller(controller)
    end
    LOG.info(fname){"ret=#{ret.count}"}
    @actions=ret
  end
  ###########################
  private

  ###########################
  # return controllers names
  def get_controllers_names
    fname = "#{self.class.name}.#{__method__}"
    controllers = Rails.application.routes.routes.map do |route|
      route.defaults[:controller]
    end.uniq
    ret=[]
    controllers.each do |ctrl|
      unless ctrl.nil?
        ret<< ctrl+"_controller"
      end
    end
    ret
  end

  def get_controllers_classes()
    fname = "#{self.class.name}.#{__method__}"
    ret=[]
    get_controllers_names.each do |ctrl|
      controller=ctrl.camelize
      # on oublie Application controller
      next if controller == 'ApplicationController'
      next if controller == 'SkillsController'
      next if controller == 'Users::RegistrationsController'
      next if controller == 'Users::SessionsController'
      next if controller == 'Rails::InfoController'
      next if controller == 'Rails::WelcomeController'
      next if controller == 'Rails::MailersController'
      next if controller == 'Devise::PasswordsController'
      unless ctrl.camelize.safe_constantize.nil?
      cctrl=ctrl.camelize.safe_constantize
      ret << cctrl
      else
        LOG.warn(fname){"route not used:#{ctrl.camelize}"}
      end
    end
    ret
  end

  def get_actions_of_controller( controller_class)
    fname = "#{self.class.name}.#{__method__}"
    ret=[]

    controller_class.instance_methods(false).sort.each do |smet|
      method = smet.to_s
      #on oublie la session et les vieux controllers
      if controller_class != 'SessionsController' &&
      (
      %w[init_objects login logout].include?(method) ||
      method =~ /(_old|authorized)($|_obsolete$|_$)/
      )
      next
      end
      # ClassSchoolController devient class_schools_controller
      sctrl=controller_class.to_s.underscore
      pos=sctrl.index("_controller")
      #class_schools_controller devient class_schools
      sctrl=sctrl[0,pos]

      ok=check_action( sctrl, method)
      ctrlmet="#{sctrl}.#{method}.#{ok}"
      ret<<ctrlmet
    #LOG.info(fname){"ctrlmet=#{ctrlmet}"}
    end
    ret
  end
  

  # statistiques
  def get_datas_count
    ret = {}
    ret[:year_preparation] = {
      matter: Matter.count,
      class_school: ClassSchool.count,
      students_by_class: Student.count/ClassSchool.count,
      l: " ",
      teaching: Teaching.count
    } 
    ret[:person] = {
      student: Student.count,
      student_enrolled: Student.where(person_status: SYLR::C_PERSON_STATUS_ENROLLED).count,
      student_waiting: Student.where(person_status: SYLR::C_PERSON_STATUS_WAITING).count,
      responsible: Responsible.count,
      responsible_enrolled: Responsible.where(person_status: SYLR::C_PERSON_STATUS_ENROLLED).count,
      responsible_waiting: Responsible.where(person_status: SYLR::C_PERSON_STATUS_WAITING).count,
      teacher: Teacher.count,
      teacher_enrolled: Teacher.where(person_status: SYLR::C_PERSON_STATUS_ENROLLED).count,
      teacher_waiting: Teacher.where(person_status: SYLR::C_PERSON_STATUS_WAITING).count,
      
    } 
    ret[:following] = {
      notebook: Notebook.count,
      present: Present.count,
      grade: Grade.count
    } 
    ret[:param] = {
      element: Element.count,
      grade_context: GradeContext.count,
      location: Location.count
    }
    ret[:debug] = {
      user: User.count,
      student_responsible: StudentResponsible.count,
      teacher_matter: TeacherMatter.count,
      schedule: Schedule.count
    }
    ret
    end

end
