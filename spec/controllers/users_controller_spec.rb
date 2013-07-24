require 'spec_helper'
describe UsersController do
  describe "GET 'index'" do
    before(:each) do
      @users = [mock_model(User,:login => "log1"), mock_model(User, :login => "log2")]
      User.stub(:all){ @users }
    end
    it "assigns a list of users" do
      User.should_receive(:all).and_return(@users)
      get 'index'
      assigns(:users).should eq @users
    end

    it "renders the template list" do
      get 'index'
      response.should render_template(:index)
    end
  end
  describe "GET 'new'" do
    it "should use new" do
      User.should_receive(:new)
      get 'new'
      response.should be_success
    end
  end
    it "renders the template new" do
      get 'new'
      response.should render_template(:new)
    end
  describe "POST '/user'" do
    before(:each) do
      @user = double(User)
      User.stub(:new){@user}
      @params={:user=>{:login=>"juliano",:passwd=>"pass",:nom=>"GOIN",:prenom=>"Julien",:mail=>"juju@lol.fr"}, :validate_passwd=>"pass"}
    end

    it "should use validate_passwd?" do
      @user.stub(:save){true}
      controller.should_receive(:validate_passwd?).with("pass","pass") { true }
      post 'create',@params
    end
    it "should use errors message when save is false" do
      controller.stub(:validate_passwd?) { true }
      @user.stub(:save){false}
      err = double()
      @user.should_receive(:errors){err}
      err.should_receive(:messages) 
      post 'create',@params
    end
    it "should render template new when save is false" do
      controller.stub(:validate_passwd?) { true }
      @user.stub(:save){false}
      err = double()
      @user.stub(:errors){err}
      err.stub(:messages)
      post 'create',@params
      response.should render_template(:new)
    end
    it "should render template new when validate_passwd? is false" do
      controller.stub(:validate_passwd?) { false }
      @user.stub(:save){true}
      err = double()
      @user.stub(:errors){err}
      err.stub(:messages)
      post 'create',@params
      response.should render_template(:new)
    end
  end
end
