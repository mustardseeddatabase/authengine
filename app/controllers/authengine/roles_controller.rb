class Authengine::RolesController < ApplicationController
  layout 'authengine/layouts/authengine'

  def index
    @all_roles = Role.find(:all, :order=>:name)
  end

  def destroy
    @role = Role.find(params[:id])
    if @role.destroy # note: model callback applies
      redirect_to authengine_roles_path
    else
      flash[:error] = "Cannot remove a role if users are assigned.<br/>Please reassign or delete users."
      redirect_to authengine_roles_path
    end
  end

  def new
    @role = Role.new
  end


 def create
    @role = Role.new(params[:role])

    if @role.save
      redirect_to authengine_roles_path
    else
      render :action => "new"
    end
  end

end
