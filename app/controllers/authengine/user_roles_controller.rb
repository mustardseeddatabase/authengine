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
end
