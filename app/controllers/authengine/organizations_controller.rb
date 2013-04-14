class Authengine::OrganizationsController < ApplicationController
  def show
    @organization = Organization.find(params[:id])
  end

  def index
    @active_organizations = Organization.active.sort
    @inactive_organizations = Organization.inactive.sort
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      flash[:notice] = "Organization saved"
      redirect_to authengine_organizations_path
    else
      render :action => :new
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
      flash[:notice] = "Organization updated"
      redirect_to authengine_organizations_path
    else
      render :action => :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.delete
    flash[:notice] = "Organization deleted"
    redirect_to authengine_organizations_path
  end
end
