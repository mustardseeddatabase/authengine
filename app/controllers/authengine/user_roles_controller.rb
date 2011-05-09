class Authengine::UserRolesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @all_roles = Role.all(:order => :name)
    @user_role = @user.user_roles.build
  end

  def create
    @user = User.find(params[:user_id])
    @user.user_roles.create(params[:user_role])
    @all_roles = Role.all(:order => :name)
    render :index
  end

  def destroy
    user_role = UserRole.find_by_role_id_and_user_id(params[:id],params[:user_id])
    user_role.destroy
    redirect_to authengine_user_user_roles_path(params[:user_id])
  end
end
