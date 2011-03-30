require 'spec_helper'

describe "authengine spec generator" do
  before(:all) do
    @ag = AuthengineGenerator.new
  end

  it "should do something" do
    @ag.copy_initializer_file.should be_true
  end
end
