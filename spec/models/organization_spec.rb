require 'spec_helper'

describe "active scope" do
  before do
    @active_organization = FactoryGirl.create(:organization, :active, :pantry)
    @inactive_organization = FactoryGirl.create(:organization, :inactive, :pantry)
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

describe "model validation" do
  it "should raise an error if neither the pantry nor the referrer attributes are true" do
    expect{ FactoryGirl.create(:organization, :active) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "should not raise an error if the pantry attribute is true" do
    expect{ FactoryGirl.create(:organization, :active, :pantry) }.not_to raise_error
  end

  it "should not raise an error if the referrer attribute is true" do
    expect{ FactoryGirl.create(:organization, :active, :referrer) }.not_to raise_error
  end
end
