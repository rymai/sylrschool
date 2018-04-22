# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # GET /resource/
  def index
    @users=User.all
  end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    fname = "#{self.class.name}.#{__method__}"
    super
    user=User.find_by_email(reg_params[:email])
    pars={}
    unless user.nil?
      pars[:name]=params[:user][:name]
    pars[:role]=params[:user][:role]
    user.update(pars) 
    else
      user=User.new(params[:user])
    end
    LOG.debug(fname) {"************************ current_user=#{user.inspect}"}
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
   end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def  reg_params
    params.require(:user).permit(:email,:name,:role)
  end
end
