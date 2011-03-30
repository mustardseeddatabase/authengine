class RolesController < ApplicationController
  layout 'application'

  def index
    @all_roles = Role.find(:all, :order=>:name)
    if params[:user_id].nil?
      render :template=>"roles/index"
    else
      @user = User.find(params[:user_id])
      render :template=>"roles/user_roles"
    end
  end


# from the user interface, where a role is assigned to a user
  def update
    if params[:user_id].nil?

    @role = Role.find(params[:id])

      respond_to do |format|
        if @role.update_attributes(params[:role])
          format.html {
            @all_roles = Role.find(:all)
            redirect_to roles_path
           }
          format.xml  { head :ok }
        else
          render :action => "edit"
        end
      end

    else
      @user = User.find(params[:user_id])
      @role = Role.find(params[:id])
      unless @user.has_role?(@role.name)
      @user.roles << @role
      end
      redirect_to user_roles_path(@user)
    end

  end

# from the user interface, where a role is removed from a user
  def destroy
    @role = Role.find(params[:id])
    if params[:user_id].nil? then
      @role.destroy
      @all_roles = Role.find(:all)
      redirect_to roles_path
    else
      @user = User.find(params[:user_id])
      if @user.has_role?(@role.name)
        @user.roles.delete(@role)
      end
      redirect_to user_roles_path(@user)
   end
  end

  def new
    @role = Role.new
  end


 def create
    @role = Role.new(params[:role])

    if @role.save
      flash[:notice] = 'role was successfully created.'
      @all_roles = Role.find(:all)
      render :template=>"roles/index"
    else
      render :action => "new"
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

end
