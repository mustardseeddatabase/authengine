#require 'spec_helper'
require File.expand_path("../../spec_helper", __FILE__)


describe 'exists_for class method' do
  before(:each) do
    @role       = Role.create(:name => 'chief')
    @controller = Controller.create(:controller_name => 'traveller')
    @action     = Action.create(:action_name => 'travel', :controller_id => @controller.id)
    @user       = Factory.create(:user, :login => 'just_me')
    @user_role  = UserRole.create(:role_id => @role.id, :user_id => @user.id)
  end

  it 'something' do
    true
  end
end
