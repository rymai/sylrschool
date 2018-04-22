#require_dependency 'acl_system2/lib/caboose/access_control'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_action_for_role
  before_filter :set_locale, :set_theme
  helper_method :current_user,:logged_in?
  # redirection vers l'action index du main si besoin
  def redirect_to_main(uri = nil, msg = nil)
    fname = "#{self.class.name}.#{__method__}"
    LOG.debug(fname){"application_controller: redirect_to_main:flash=#{flash.inspect} msg=#{msg}"}
    flash[:notice] = msg if msg
    redirect_to(uri || { controller: "main", action: :index })
  end

  # definition de la langue
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
    elsif session[:language]
      I18n.locale = session[:language]
    else
      I18n.locale = I18n.default_locale
    end
    session[:language] = I18n.locale
  end

  # definition du theme
  def set_theme
    if params[:theme]
      theme = params[:theme]
    elsif session[:theme]
      theme = session[:theme]
    else
      theme = SYLR::V_DEFAULT_THEME
    end
    session[:theme] = theme
  end


  # user devient UserController, class_school devient ClassSchoolController
  def controller_class_from_name(name)
    "#{name}_controller".camelize
  end

  # check if action is permitted for the role
  def check_action_for_role
    fname = "#{self.class.name}.#{__method__}"
    ok=true
    controller=params["controller"]
    action=params["action"]
    pos=controller.index("/")
    # que les classes de 1er niveau (pas users/ et devise/...)
    if pos.nil?
      if logged_in?
        ok=check_action controller, action
      else
        ok=false
        msg="not logged!!"
      end
    end
    unless ok
      msg="Action not authorized on #{controller_class_from_name(controller)} for action #{action}"
      respond_to do |format|
        format.html { redirect_to_main(nil, msg) }
        format.xml { head :ok }
      end
    end

  end

  def check_action controller, action
    fname = "#{self.class.name}.#{__method__}"
    LOG.info(fname){"controller=#{controller} action=#{action}"}
    ok=true
    if SYLR::C_CTRL_CLASS_USER.include? controller
      # controllers users
      LOG.info(fname){"controller=#{controller} is user}"}
      # tout pour le support
      if is_support?
      ok=true
      else
      #
      # pour les autres roles
      #
        ok=false
        case current_user.role
        when SYLR::C_ROLE_TEACHER
          if SYLR::C_CTRL_ACTION_GREAD.include? action
            # le controller est il un des controlleurs permettant le read
            ok= SYLR::C_CTRL_TEACHER_READ.include? controller
          elsif SYLR::C_CTRL_ACTION_GWRITE.include? action
            # le controller est il un des controlleurs permettant le write
            ok= SYLR::C_CTRL_TEACHER_WRITE.include? controller
          end
        when SYLR::C_ROLE_STUDENT
          if SYLR::C_CTRL_ACTION_GREAD.include? action
            ok= SYLR::C_CTRL_STUDENT_READ.include? controller
          elsif SYLR::C_CTRL_ACTION_GWRITE.include? action
            ok= SYLR::C_CTRL_STUDENT_WRITE.include? controller
          end
        when SYLR::C_ROLE_RESPONSIBLE
          if SYLR::C_CTRL_ACTION_GREAD.include? action
            ok= SYLR::C_CTRL_RESPONSIBLES_READ.include? controller
          elsif SYLR::C_CTRL_ACTION_GWRITE.include? action
            ok= SYLR::C_CTRL_RESPONSIBLES_WRITE.include? controller
          end
        when SYLR::C_ROLE_VISITOR
          if SYLR::C_CTRL_ACTION_GREAD.include? action
            ok= SYLR::C_CTRL_VISITORS_READ.include? controller
          elsif SYLR::C_CTRL_ACTION_GWRITE.include? action
            ok= SYLR::C_CTRL_VISITORS_WRITE.include? controller
          end
        end
      end
    else
    # admin menus: tout pour admin et support, rien pour les autres
      unless is_admin? || is_support?
      ok=false
      end
    end
    ok
  end

  def logged_in?
    current_user != nil
  end

  def is_admin?
    is_role? SYLR::C_ROLE_ADMIN
  end

  def is_support?
    is_role? SYLR::C_ROLE_SUPPORT
  end

  def is_responsible?
    is_role? SYLR::C_ROLE_RESPONSIBLE
  end

  def is_student?
    is_role? SYLR::C_ROLE_STUDENT
  end

  def is_teacher?
    is_role? SYLR::C_ROLE_TEACHER
  end

  def is_visitor?
    is_role? SYLR::C_ROLE_VISITOR
  end

  def is_role? role
    ok=false
    if logged_in?
      ok=current_user.role==role
    end
  end

  protected

end