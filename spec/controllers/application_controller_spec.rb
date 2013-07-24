require 'spec_helper'


describe ApplicationController do

  describe "validate_passwd" do
    it "should return true when the 2 parms are equals" do
      controller.validate_passwd?('pass','pass').should == true
    end
    it "should return false when the 2 parms are not equals" do
      controller.validate_passwd?('pass','passwrong').should == false
    end
  end

end
