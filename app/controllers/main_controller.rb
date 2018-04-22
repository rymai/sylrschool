class MainController < ApplicationController
  # GET /mains
  # GET /mains.json

  skip_before_action :authenticate_user!
  # pour eviter une boucle sur index
  skip_before_action :check_action_for_role
  #efore_action :authenticate_user!
  def index
  end

  def show
  end

  def tools
    @languages=SYLR::C_ALL_LANGUAGES
    @themes=SYLR::C_ALL_THEMES
  end

  def check_action
    fname = "#{self.class.name}.#{__method__}"
    LOG.info(fname){"params=#{params}"}
  end

end
