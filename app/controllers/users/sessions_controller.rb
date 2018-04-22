# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user!
  ###before_action :set_session, only: [:show, :edit, :update, :destroy]#skip_before_action :authenticate_user!
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    pars={}
    pars[:role]=params[:user][:role]
    pars[:name]=params[:user][:name]
    current_user.update(pars)
    puts "************************ current_user=#{current_user.inspect}"

  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected
  def set_session
    @session = Session.find(params[:id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  #def configure_sign_in_params
  #  devise_parameter_sanitizer.permit(:sign_in, keys: [:name,:role])
  # end
  def  session_params
    params.require(:session).permit(:name,:role,:custo)
  end
end
