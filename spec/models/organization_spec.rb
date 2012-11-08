require 'spec_helper'

describe "active scope" do
  before do
    @active_organization = FactoryGirl.create(:organization, :active)
    @inactive_organization = FactoryGirl.create(:organization, :inactive)
  end
  let(:active_organizations){ Organization.active }
  let(:inactive_organizations){ Organization.inactive }

  it "should retrieve a single active organization" do
    active_organizations.size.should == 1
    active_organizations[0].should == @active_organization
  end

  it "should retrieve a single inactive organization" do
    inactive_organizations.size.should == 1
    inactive_organizations[0].should == @inactive_organization
  end
end
