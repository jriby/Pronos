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

  describe "user_exist" do
    context "the user doesnt exist" do
      before(:each) do
        User.stub(:exist?){false}
      end
      
      it "should redirect" do
        controller.should_receive(:redirect_to)
        controller.user_exist
      end
    end

    context "the user exist" do
      before(:each) do
        User.stub(:exist?){true}
      end

      it "shoul use method exist? from user" do
        User.should_receive(:exist?)
        controller.user_exist
      end

      it "should have respinse status 200" do
        controller.user_exist
        response.status.should == 200
      end
    end
  end
end
