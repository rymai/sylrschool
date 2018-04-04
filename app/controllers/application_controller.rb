#require_dependency 'acl_system2/lib/caboose/access_control'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :set_locale, :set_theme
  helper_method :current_user,:logged_in?
  # redirection vers l'action index du main si besoin
  def redirect_to_main(uri = nil, msg = nil)
    fname = "#{self.class.name}.#{__method__}"
    LOG.debug(fname){"application_controller: redirect_to_main:flash=#{flash.inspect} msg=#{msg}"}
    flash[:notice] = msg if msg
    redirect_to(uri || { controller: :main, action: :index })
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
      theme = SYLR::C_DEFAULT_THEME
    end
    session[:theme] = theme
  end

  protected

end