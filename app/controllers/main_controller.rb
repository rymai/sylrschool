class MainController < ApplicationController
  # GET /mains
  # GET /mains.json

  skip_before_action :authenticate_user!
  # pour eviter une boucle sur index
  skip_before_action :check_action_for_role
  def index
  end

  def show
  end

  def tools
    @languages=SYLR::C_ALL_LANGUAGES
    @themes=SYLR::C_ALL_THEMES
  end

  def index_actions
    fname = "#{self.class.name}.#{__method__}"
    LOG.info(fname){"====================================params=#{params}"}
    ret=[]
    get_controllers_classes().each do |controller|
      ret << get_actions_of_controller(controller)
    end
    LOG.info(fname){"====================================ret=#{ret}"}
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
      ctrlmet="#{controller_class}.#{smet}"
      ret<<ctrlmet
      LOG.info(fname){"ctrlmet=#{ctrlmet}"}
    end
    ret
  end

end
