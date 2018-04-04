class MainController < ApplicationController
    # GET /mains
    # GET /mains.json
    
  before_action :authenticate_user!
    def index
    end
    def show
    end
    
    def tools
      @languages=SYLR::C_ALL_LANGUAGES
      @themes=SYLR::C_ALL_THEMES
    end

end
