class Authengine::UserRolesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_roles = Role.all(:order => :name)
    @user_role = PersistentUserRole.new(:user_id => @user.id)
  end

  def create
    @user = User.find(params[:user_id])
    # session_user_roles are created by the process of downgrading the role
    # associated with the current session for the purpose of limiting access
    # when configuring a session for just one purpose (e.g.) checkout
    if params[:session_user_role]
      @user.session_user_roles.create(params[:session_user_role].delete_if{|k,v| k == "type" })
      role_name = Role.find(params[:session_user_role][:role_id]).name
      flash[:info] = "Current session now has #{role_name} role"
      redirect_to home_path
    # persistent_user_roles are created as the permanent role assignment for a user
    else
      @user.persistent_user_roles.create(params[:user_role])
      redirect_to authengine_user_user_roles_path(@user)
    end
  end

  def destroy
    persistent_user_role = PersistentUserRole.find_by_role_id_and_user_id(params[:id],params[:user_id])
    persistent_user_role.destroy
    redirect_to authengine_user_user_roles_path(params[:user_id])
  end

  def new
    @roles = Role.lower_than(current_user.persistent_user_roles.map(&:role))
    @session_user_role = SessionUserRole.new()
  end

end
