# This controller handles the login/logout function of the site.
require "date"

class Authengine::SessionsController < ApplicationController
  layout 'authengine/layouts/authengine'

  skip_before_filter :load_actions_list, :check_permissions, :log_useractions, :log_referer, :only => [:new, :create, :destroy]


  def new
    @page_title = "Login"
  end

  def create
    logger.info "session controller: create"
    password_authentication(params[:login], params[:password])
    remove_session_user_roles
  end

  def destroy
    self.current_user.forget_me if logged_in?
    remove_session_user_roles
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to login_path
  end

protected
  def remove_session_user_roles
    current_user.session_user_roles.clear if current_user != :false
  end

  def password_authentication(login, password)
    user = User.authenticate(login, password)
    if user == nil
      #failed_login_log.warn("\n#{Time.now}:  Failed login with parameters: username: #{login}, password: #{password}, remote address: #{request.env["REMOTE_ADDR"]}")
      failed_login("Your username or password is incorrect.")
    elsif user.activated_at.blank?
      failed_login("Your account is not active, please check your email for the activation code.")
    elsif user.enabled == false
      failed_login("Your account has been disabled, please contact administrator.")
    else
      self.current_user = user
      successful_login
    end
  end

private

  def failed_login(message)
    logger.info "login failed with message: #{message}"
    flash[:error] = message
    render :action => 'new'
  end

  def successful_login
    # 'remember me' is not used in this application
    #if params[:remember_me] == "1"
      #self.current_user.remember_me
      #cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
    #end
#   user is already logged-in
    flash[:notice] = "Logged in successfully"
    return_to = session[:return_to]
    if return_to.nil?
      redirect_to home_path
    else
      redirect_to return_to
    end
  end

end
