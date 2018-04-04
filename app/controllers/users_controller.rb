class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  skip_before_action :authenticate_user!
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  #def show
  #end

  # GET /users/new
  #def new
  #  @user = User.new
  #end

  # GET /users/1/edit
  #def edit
  #end

  # POST /users
  # POST /users.json
  #def create
  #end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  #def update
  #end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
